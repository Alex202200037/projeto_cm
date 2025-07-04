import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'firebase_service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PublishAdModal extends StatefulWidget {
  const PublishAdModal({super.key});

  @override
  State<PublishAdModal> createState() => _PublishAdModalState();
}

class _PublishAdModalState extends State<PublishAdModal> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _categoriaController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _localizacaoController = TextEditingController();
  final _detalhesController = TextEditingController();
  final _precoController = TextEditingController();
  bool _moradaValida = true;
  bool _isCheckingMorada = false;
  String? _moradaErro;

  static const kGoogleApiKey = 'AIzaSyBDmNp-KkjWoDrby_GUmvp8Y2jNjDfqlq8';
  GooglePlace? googlePlace;
  List<AutocompletePrediction> predictions = [];

  final FocusNode _moradaFocusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    googlePlace = GooglePlace(kGoogleApiKey);
    _localizacaoController.addListener(_onMoradaChanged);
    _moradaFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_moradaFocusNode.hasFocus) {
      _removeOverlay();
    } else if (_localizacaoController.text.isNotEmpty && predictions.isNotEmpty) {
      _showOverlay();
    }
  }

  void _showOverlay() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _removeOverlay();
      if (!_moradaFocusNode.hasFocus || predictions.isEmpty) return;
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width - 48, // padding horizontal 24 + 24
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 56), // altura do campo + margem
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 220),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  final p = predictions[index];
                  return ListTile(
                    title: Text(p.description ?? ''),
                    onTap: () => _selectPrediction(p),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onMoradaChanged() async {
    final input = _localizacaoController.text;
    if (!_moradaFocusNode.hasFocus) return;
    if (input.isNotEmpty) {
      try {
        setState(() { _isCheckingMorada = true; });
        var result = await googlePlace!.autocomplete.get(input, language: 'pt', components: [Component('country', 'pt')]);
        if (result != null && result.predictions != null) {
          setState(() {
            predictions = result.predictions!;
            _isCheckingMorada = false;
          });
          if (_moradaFocusNode.hasFocus && predictions.isNotEmpty) {
            _showOverlay();
          } else {
            _removeOverlay();
          }
        } else {
          setState(() {
            predictions = [];
            _isCheckingMorada = false;
          });
          _removeOverlay();
        }
      } catch (e) {
        setState(() { _isCheckingMorada = false; });
        _removeOverlay();
      }
    } else {
      setState(() { predictions = []; });
      _removeOverlay();
    }
  }

  void _selectPrediction(AutocompletePrediction p) async {
    final details = await googlePlace!.details.get(p.placeId!);
    if (details != null && details.result != null) {
      final address = details.result!.formattedAddress ?? p.description ?? '';
      final lat = details.result!.geometry?.location?.lat;
      final lng = details.result!.geometry?.location?.lng;
      setState(() {
        _localizacaoController.text = address;
        _detalhesController.text = 'Lat: $lat, Lng: $lng';
        predictions = [];
      });
      _removeOverlay();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _categoriaController.dispose();
    _descricaoController.dispose();
    _localizacaoController.dispose();
    _detalhesController.dispose();
    _precoController.dispose();
    _moradaFocusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Publicar Anúncio', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SafeArea(
                            child: Wrap(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.photo_library),
                                  title: const Text('Galeria'),
                                  onTap: () async {
                                    final picked = await _picker.pickImage(source: ImageSource.gallery);
                                    if (picked != null) {
                                      setState(() {
                                        _pickedImage = File(picked.path);
                                      });
                                    }
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.camera_alt),
                                  title: const Text('Câmara'),
                                  onTap: () async {
                                    final picked = await _picker.pickImage(source: ImageSource.camera);
                                    if (picked != null) {
                                      setState(() {
                                        _pickedImage = File(picked.path);
                                      });
                                    }
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: _pickedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(_pickedImage!, height: 120, width: 120, fit: BoxFit.cover),
                            )
                          : Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(Icons.add_a_photo, size: 48, color: Color(0xFFB0B0B0)),
                            ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Toque para escolher ou tirar foto'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: 'Título*'),
                validator: (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                enableSuggestions: true,
                autocorrect: true,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _categoriaController,
                decoration: const InputDecoration(labelText: 'Categoria*'),
                validator: (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                enableSuggestions: true,
                autocorrect: true,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição*'),
                maxLines: 2,
                validator: (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                enableSuggestions: true,
                autocorrect: true,
              ),
              const SizedBox(height: 12),
              CompositedTransformTarget(
                link: _layerLink,
                child: TextFormField(
                  controller: _localizacaoController,
                  focusNode: _moradaFocusNode,
                  decoration: const InputDecoration(
                    labelText: 'Morada (Google Autocomplete)*',
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  enableSuggestions: true,
                  autocorrect: true,
                ),
              ),
              if (_isCheckingMorada)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: LinearProgressIndicator(minHeight: 2),
                ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _detalhesController,
                decoration: const InputDecoration(labelText: 'Detalhes'),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                enableSuggestions: true,
                autocorrect: true,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _precoController,
                decoration: const InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                enableSuggestions: true,
                autocorrect: true,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade300),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2A815E)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate() && _moradaValida) {
                          await FirebaseService().publishAd(
                            titulo: _tituloController.text,
                            categoria: _categoriaController.text,
                            descricao: _descricaoController.text,
                            localizacao: _localizacaoController.text,
                            detalhes: _detalhesController.text,
                            preco: _precoController.text,
                            fotoUrl: _pickedImage?.path,
                          );
                          Navigator.pop(context);
                        } else {
                          setState(() { _moradaValida = false; });
                        }
                      },
                      child: const Text('Publicar Anúncio'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 