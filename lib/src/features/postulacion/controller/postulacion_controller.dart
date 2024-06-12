import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/postulacion/model/postulacion_model.dart';
import 'package:helpu/src/repository/postulacion_repository/postulacion_repository.dart';


class PostulacionController extends GetxController {
  static PostulacionController get instance => Get.find();

  final estado = false.obs;

  var isLoading = true.obs;
  var postulaciones = <PostulacionModel>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPostulaciones();
  }

  void fetchPostulaciones() async {
    try {
      User? user = await FirebaseAuth.instance.currentUser;
      isLoading(true);
      errorMessage('');
      print(user?.email);
      var result = await PostulacionRepository().getPostulacionesByEmailStudent(user?.email);
      postulaciones(result);
      print(postulaciones.length);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  final postulacionRepo = Get.put(PostulacionRepository());

  Future<void> createPostulacion(PostulacionModel postulacion) async {
    await postulacionRepo.createPostulacion(postulacion);
  }

  Future<PostulacionModel> getPostulacionDetails(String id) async {
    PostulacionModel  postulacionModel = await postulacionRepo.getPostulacionDetails(id);
    return postulacionModel;
  }

  Future<void> togglePostulacionAceptado(String? email, String? id, bool estado) async {
    await postulacionRepo.togglePostulacionAceptado(email, id,estado);
  }

  Future<List<PostulacionModel>> getPostulacionesbyEmail() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      print(firebaseUser.email);
      final practicas = await postulacionRepo.getPostulacionesByEmailStudent(firebaseUser.email);
      return practicas;
    }
    else {
      throw Exception('No hay ningún usuario autenticado.');
    }
  }

  Future<List<PostulacionModel>> getPostulacionesByPractica(String? idPractica) async {
    final postulaciones = await postulacionRepo.getPostulacionesByPractica(idPractica);
    return postulaciones;
  }

  Future<List<PostulacionModel>> getPostulaciones() async {
    final List<PostulacionModel> postulacionesModel = await postulacionRepo.getPostulaciones();
    return postulacionesModel;

  }


  }


