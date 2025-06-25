import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';

class PublishAdModal extends StatefulWidget {
  final void Function(Map<String, String>) onPublish;
  const PublishAdModal({required this.onPublish, super.key});

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
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: 'Título*'),
                validator: (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _categoriaController,
                decoration: const InputDecoration(labelText: 'Categoria*'),
                validator: (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição*'),
                maxLines: 2,
                validator: (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
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
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _precoController,
                decoration: const InputDecoration(labelText: 'Preço'),
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
                          widget.onPublish({
                            'titulo': _tituloController.text,
                            'categoria': _categoriaController.text,
                            'descricao': _descricaoController.text,
                            'localizacao': _localizacaoController.text,
                            'detalhes': _detalhesController.text,
                            'preco': _precoController.text,
                          });
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