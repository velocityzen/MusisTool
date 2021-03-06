import SwiftUI
import SwiftUIFlux

struct AlbumsView: ConnectedView {
  struct Props {
    let albums: OrderedSet<Album>
  }
  
  func body(props: Props) -> some View {
      GridView(props.albums, itemWidth: ALBUM_WIDTH, padding: ALBUM_PADDING) { album in
        AlbumView(album)
          .onTapGesture {
            self.openAlbum(album.id)
          }
      }
  }
  
}

extension AlbumsView {
  func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
    return Props(albums: state.albums.items)
  }
}

extension AlbumsView {
  func openAlbum(_ id: UUID) {
    store.dispatch(action: UIActions.Open(id: id))
  }
  
  func removeAlbum(_ id: UUID) {
    store.dispatch(action: AlbumsActions.Remove(id: id))
  }
  
  func removeAlbums(_ ids: [UUID]) {
    store.dispatch(action: AlbumsActions.RemoveAll(ids: ids))
  }
}
