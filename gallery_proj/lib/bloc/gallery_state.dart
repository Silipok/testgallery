import 'package:equatable/equatable.dart';
import 'package:gallery_proj/model/picture.dart';


abstract class GalleryState extends Equatable {
  const GalleryState();

  @override
  List<Object> get props => [];
}

class GalleryInitial extends GalleryState {}

class GalleryFailure extends GalleryState {}

class GallerySuccess extends GalleryState {
  final List<Picture> gallery;
  final bool hasReachedMax;

  const GallerySuccess({
    this.gallery,
    this.hasReachedMax,
  });

  GallerySuccess copyWith({
    List<Picture> gallery,
    bool hasReachedMax,
  }) {
    return GallerySuccess(
      gallery: gallery ?? this.gallery,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [gallery, hasReachedMax];

  @override
  String toString() =>
      'PostLoaded { posts: ${gallery.length}, hasReachedMax: $hasReachedMax }';
}