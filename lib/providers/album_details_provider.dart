import 'package:flutter/material.dart';
import 'package:network_library_provider/models/album_model.dart';
import 'package:network_library_provider/network_module/api_response.dart';
import 'package:network_library_provider/repositories/album_repo.dart';

class AlbumDetailsProvider with ChangeNotifier {
  AlbumRepository? _albumRepository;

  ApiResponse<Album>? _album;

  ApiResponse<Album>? get album => _album;

  AlbumDetailsProvider() {
    _albumRepository = AlbumRepository();
    fetchAlbumDetails();
  }

  fetchAlbumDetails() async {
    _album = ApiResponse.loading('loading... ');
    notifyListeners();
    try {
      Album album = await _albumRepository!.fetchAlbumDetails();
      _album = ApiResponse.completed(album);
      notifyListeners();
    } catch (e) {
      _album = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
