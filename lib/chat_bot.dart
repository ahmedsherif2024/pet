import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({
    required this.apiKey,
    super.key,
  });

  final String apiKey;

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late final GenerativeModel _model;
  late final GenerativeModel _visionModel;
  late final ChatSession _chat;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  // final FocusNode _textFieldFocus = FocusNode();
  final List<({Image? image, String? text, bool fromUser})> _generatedContent =
  <({Image? image, String? text, bool fromUser})>[];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: widget.apiKey,
    );
    _visionModel = GenerativeModel(
      model: 'gemini-pro-vision',
      apiKey: widget.apiKey,
    );
    _chat = _model.startChat();
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
          (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textFieldDecoration = InputDecoration(
      contentPadding: const EdgeInsets.all(15),
      hintText: 'Enter a prompt...',
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: widget.apiKey.isNotEmpty
                ? ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, idx) {
                final content = _generatedContent[idx];
                return MessageWidget(
                  text: content.text,
                  image: content.image,
                  isFromUser: content.fromUser,
                );
              },
              itemCount: _generatedContent.length,
            )
                : ListView(
              children: const [
                Text(
                  'No API key found. Please provide an API Key using '
                      "'--dart-define' to set the 'API_KEY' declaration.",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 15,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    autofocus: true,
                    // focusNode: _textFieldFocus,
                    decoration: textFieldDecoration,
                    controller: _textController,
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        _sendChatMessage(value);
                      } else {}
                    },
                  ),
                ),
                const SizedBox.square(dimension: 15),
                IconButton(
                  onPressed: !_loading
                      ? () async {
                    _sendImagePrompt(_textController.text);
                  }
                      : null,
                  icon: Icon(
                    Icons.image,
                    color: _loading
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
                if (!_loading)
                  IconButton(
                    onPressed: () async {
                      if (_textController.text.isNotEmpty) {
                        _sendChatMessage(_textController.text);
                      } else {}
                    },
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                else
                  const CircularProgressIndicator(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final picker = ImagePicker();
  File? model_image;

  Future<void> _sendImagePrompt(String message) async {
    _showImagePicker(context, message);
  }

  void _showImagePicker(BuildContext context, String message) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // color: cardColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('التقاط صورة باستخدام الكاميرا'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.camera, message);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('اختيار صورة من المعرض'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery, message);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(ImageSource type, String message) async {
    final pickedFile = await picker.pickImage(source: type);
    if (pickedFile != null) {
      setState(() {
        model_image = File(pickedFile.path);
      });

      try {
        if (model_image != null) {
          setState(() {
            _loading = true;
          });

          List<int> imageBytes = await model_image!.readAsBytes();
          Uint8List uint8List = Uint8List.fromList(imageBytes);

          final content = [
            Content.multi([
              TextPart(message),
              DataPart('image/jpeg', uint8List),
            ])
          ];

          if (message.isNotEmpty) {
            _generatedContent.add((
            image: Image.file(model_image!),
            text: message,
            fromUser: true
            ));

            var response = await _visionModel.generateContent(content);
            var text = response.text;
            _generatedContent.add((image: null, text: text, fromUser: false));

            if (text == null) {
              _showError('No response from API.');
              return;
            } else {
              setState(() {
                _loading = false;
                _scrollDown();
              });
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                    'قم بكتابة المطلوب من هذه الصورة أولا ثم اختيار الصورة')));
          }
        } else {
          // لم يتم اختيار صورة
        }
      } catch (e) {
        _showError(e.toString());
        setState(() {
          _loading = false;
        });
      } finally {
        _textController.clear();
        setState(() {
          _loading = false;
        });
        // _textFieldFocus.requestFocus();
      }
    }
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });

    try {
      _generatedContent.add((image: null, text: message, fromUser: true));
      final response = await _chat.sendMessage(
        Content.text(message),
      );
      final text = response.text;
      _generatedContent.add((image: null, text: text, fromUser: false));

      if (text == null) {
        _showError('No response from API.');
        return;
      } else {
        setState(() {
          _loading = false;
          _scrollDown();
        });
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
      });
      // _textFieldFocus.requestFocus();
    }
  }

  void _showError(String message) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Something went wrong'),
          content: SingleChildScrollView(
            child: SelectableText(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    this.image,
    this.text,
    required this.isFromUser,
  });

  final Image? image;
  final String? text;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 520),
            decoration: BoxDecoration(
              color: isFromUser
                  ? Theme.of(context).colorScheme.inversePrimary
                  : Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            margin: EdgeInsets.only(
              bottom: 8,
              left: isFromUser ? MediaQuery.of(context).size.width * 0.2 : 0,
              right: !isFromUser ? MediaQuery.of(context).size.width * 0.2 : 0,
            ),
            child: Column(
              children: [
                if (text != null)
                  GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: text!)).then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Copied to your clipboard !')));
                        });
                      },
                      child: MarkdownBody(data: text!)),
                if (image != null) image!,
              ],
            ),
          ),
        ),
      ],
    );
  }
}