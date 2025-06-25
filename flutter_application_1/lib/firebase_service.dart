import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- AUTH ---
  Future<User?> registerWithEmail(String email, String password, String nome, {String? fotoUrl, String tipo = 'farmer'}) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await _db.collection('users').doc(cred.user!.uid).set({
      'uid': cred.user!.uid,
      'email': email,
      'nome': nome,
      'fotoUrl': fotoUrl ?? '',
      'tipo': tipo,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return cred.user;
  }

  Future<User?> loginWithEmail(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return cred.user;
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final cred = await _auth.signInWithCredential(credential);
    // Se for novo, criar perfil
    final doc = await _db.collection('users').doc(cred.user!.uid).get();
    if (!doc.exists) {
      await _db.collection('users').doc(cred.user!.uid).set({
        'uid': cred.user!.uid,
        'email': cred.user!.email,
        'nome': cred.user!.displayName ?? '',
        'fotoUrl': cred.user!.photoURL ?? '',
        'tipo': 'farmer',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
    return cred.user;
  }

  Future<void> logout() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }

  Stream<User?> get userChanges => _auth.authStateChanges();

  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.exists ? doc.data() : null;
  }

  // --- ANÚNCIOS ---
  Future<void> publishAd({
    required String titulo,
    required String categoria,
    required String descricao,
    required String localizacao,
    required String detalhes,
    required String preco,
    String? fotoUrl,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Not logged in');
    await _db.collection('anuncios').add({
      'titulo': titulo,
      'categoria': categoria,
      'descricao': descricao,
      'localizacao': localizacao,
      'detalhes': detalhes,
      'preco': preco,
      'fotoUrl': fotoUrl ?? '',
      'userId': user.uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Map<String, dynamic>>> getAnunciosStream() {
    return _db.collection('anuncios').orderBy('createdAt', descending: true).snapshots().map((snap) =>
      snap.docs.map((doc) => doc.data()).toList()
    );
  }
} 