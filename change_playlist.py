from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot
from matplotlib.artist import Artist
import pandas as pd
from tinytag import TinyTag

music = pd.read_csv('course_project/music.csv')

class playlist_change(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.pictureath_ = ''
        self.name_ = ''
        self.music_ = music
        self.quantity_ = self.music_.shape[0]

    pictureath = pyqtSignal(str, arguments=['text_'])
    name = pyqtSignal(str, arguments=['text_'])

    
    updListView_music = pyqtSignal()
    addListView_music = pyqtSignal(int,str,str,str,bool,bool, arguments=['id_','author_','publish_year_','track_','liked_','add_'])
    dropListView_music =  pyqtSignal(int, arguments=['id'])
    clearListView_music = pyqtSignal()

    def set_data_(self):
        if not self.music_.empty:
            for i, row in self.music_.iterrows():
                self.addListView_music.emit(row.id, row.artist,str(row.publish_year),row.song_title, row.liked, False)

    # @pyqtSlot(str)
    # def get_file(self,x):
    #     # складываем два аргумента и испускаем сигнал
    #     # self.sumResult.emit(arg1 + arg2)
    #     self.musicpath_ = x.split('///')[1]
    #     tag = TinyTag.get(self.musicpath_)
    #     print('file path: ',self.musicpath_)

    #     self.musicpath.emit(self.musicpath_)

    #     self.genre_ = tag.genre 
    #     self.title_ = tag.title
    #     self.album_ = tag.album
    #     self.artistname_ = tag.artist
    #     self.duration_ = tag.duration

    #     self.genre.emit(self.genre_)
    #     self.title.emit(self.title_)
    #     self.album.emit(self.album_)
    #     self.artistname.emit(self.artistname_)
    #     print('music duration: ', self.duration_)

    
    @pyqtSlot(str)
    def get_picture(self,x):
        self.pictureath_ = x
        print('file path: ',self.pictureath_)
        self.pictureath.emit(self.pictureath_)

    @pyqtSlot(str)
    def upd_info(self, x):
        """
        """
        print('x: ', x)
        if '|picture_path|#' in x:
            self.pictureath_ = x.split('|#')[1]
            print(self.pictureath_)
        elif '|name|#' in x:
            self.name_ = x.split('|#')[1]
            print(self.name_)   

    @pyqtSlot(str,int,bool)
    def change_music(self, a,b,c):
        """
        """
        print(a)
        print('change_ ' + a,b,c)
        # self.seekSlider.emit(100)        
        # return self.music.
        # self.updListView_music.emit(10)

    @pyqtSlot()
    def clear(self):
        self.pictureath_ = ''
        self.name_ = ''
    
    @pyqtSlot()
    def save(self):
        """
        """
        print('save')

    @pyqtSlot()
    def set(self):
        """
        """
        self.set_data_()
        print('save')
    
    @pyqtSlot(int)
    def set_playlist(self, id_):
        print('upd_p ', id_)
        self.name.emit(str(id_))


if  __name__ == "__main__":
    import sys
 
    # создаём экземпляр приложения
    app = QGuiApplication(sys.argv)
    # создаём QML движок
    engine = QQmlApplicationEngine()
    # создаём объект 
    playlist_change = playlist_change()
    
    # и регистрируем его в контексте QML
    engine.rootContext().setContextProperty("playlist_change", playlist_change)
    # загружаем файл qml в движок
    engine.load("change_playlist/change_playlist.qml")
    playlist_change.set_data_()
    engine.quit.connect(app.quit)
    sys.exit(app.exec_())