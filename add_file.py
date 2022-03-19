from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot
from matplotlib.artist import Artist
import pandas as pd
from tinytag import TinyTag


class Music_Add(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.musicpath_ = ''
        self.pictureath_ = ''
        self.genre_ = ''
        self.title_ = ''
        self.album_ = ''
        self.artistname_ = ''

    
    musicpath = pyqtSignal(str, arguments=['text_'])
    pictureath = pyqtSignal(str, arguments=['text_'])
    genre = pyqtSignal(str, arguments=['text_'])
    title = pyqtSignal(str, arguments=['text_'])
    album = pyqtSignal(str, arguments=['text_'])
    artistname = pyqtSignal(str, arguments=['text_'])

 
    # слот для суммирования двух чисел
    @pyqtSlot(str)
    def get_file(self,x):

        self.musicpath_ = x.split('///')[1]
        tag = TinyTag.get(self.musicpath_)
        print('file path: ',self.musicpath_)

        self.musicpath.emit(self.musicpath_)

        self.genre_ = tag.genre 
        self.title_ = tag.title
        self.album_ = tag.album
        self.artistname_ = tag.artist
        self.duration_ = tag.duration

        self.genre.emit(self.genre_)
        self.title.emit(self.title_)
        self.album.emit(self.album_)
        self.artistname.emit(self.artistname_)
        print('music duration: ', self.duration_)

    
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
        if '|music_path|#' in x:
            self.musicpath_ = x.split('|#')[1]
            print(self.musicpath_)
        elif '|picture_path|#' in x:
            self.pictureath_ = x.split('|#')[1]
            print(self.pictureath_)
        elif '|artist_name|#' in x:
            self.artistname_ = x.split('|#')[1]
            print(self.artistname_)
        elif '|genre|#' in x:
            self.genre_ = x.split('|#')[1]
            print(self.genre_)
        elif '|genre|#' in x:
            self.genre_ = x.split('|#')[1]
            print(self.genre_)
        elif '|title|#' in x:
            self.title_ = x.split('|#')[1]
            print(self.title_)
        elif '|Album|#' in x:
            self.album_ = x.split('|#')[1]
            print(self.album_)            


    @pyqtSlot()
    def save(self):
        """
        """
        print('save')
    
    @pyqtSlot()
    def clear(self):
        """
        """
        print('clear')
        self.musicpath_ = ''
        self.pictureath_ = ''
        self.genre_ = ''
        self.title_ = ''
        self.album_ = ''
        self.artistname_ = ''
        self.genre.emit(self.genre_)
        self.title.emit(self.title_)
        self.album.emit(self.album_)
        self.artistname.emit(self.artistname_)
        self.pictureath.emit(self.pictureath_)
        self.musicpath.emit(self.musicpath_)


    

    

if  __name__ == "__main__":
    import sys
 
    # создаём экземпляр приложения
    app = QGuiApplication(sys.argv)
    # создаём QML движок
    engine = QQmlApplicationEngine()
    # создаём объект 
    music_add = Music_Add()
    # и регистрируем его в контексте QML
    engine.rootContext().setContextProperty("music_add", music_add)
    # загружаем файл qml в движок
    engine.load("test_2/add_file.qml")
 
    engine.quit.connect(app.quit)
    sys.exit(app.exec_())