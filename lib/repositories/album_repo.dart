import 'package:network_library_provider/models/album_model.dart';
import 'package:network_library_provider/network_module/api_path.dart';
import 'package:network_library_provider/network_module/http_client.dart';

class AlbumRepository {
  Future<Album> fetchAlbumDetails() async {
    final response = await HttpClient.instance
        .get(APIPathHelper.getValue(APIPath.fetch_album));
    print("Response - $response");
    return Album.fromJson(response);
  }
}
