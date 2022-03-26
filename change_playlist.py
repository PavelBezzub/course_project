from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot
from matplotlib.artist import Artist
import pandas as pd
from tinytag import TinyTag

music = pd.read_csv('music.csv')

class playlist_change(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.picturepath_ = ''
        self.name_ = ''
        self.music_ = music
        self.quantity_ = self.music_.shape[0]

    picturepath = pyqtSignal(str, arguments=['text_'])
    picture = pyqtSignal(str, arguments=['text_'])
    name = pyqtSignal(str, arguments=['text_'])

    
    updListView_music = pyqtSignal()
    addListView_music = pyqtSignal(int,str,str,str,bool,bool, arguments=['id_','author_','publish_year_','track_','liked_','add_'])
    dropListView_music =  pyqtSignal(int, arguments=['id'])
    clearListView_music = pyqtSignal()

    def set_data_(self):
        if not self.music_.empty:
            for i, row in self.music_.iterrows():
                self.addListView_music.emit(row.id, row.artist,str(row.publish_year),row.song_title, row.liked, False)
    
    @pyqtSlot(str)
    def get_picture(self,x):
        self.picturepath_ = x
        print('file path: ',self.picturepath_)
        self.picturepath.emit(self.picturepath_)
        self.picture.emit(self.picturepath_)

    @pyqtSlot(str)
    def upd_info(self, x):
        """
        """
        print('x: ', x)
        if '|picture_path|#' in x:
            self.picturepath_ = x.split('|#')[1]
            print(self.picturepath_)
            self.picture.emit(self.picturepath_)
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
        self.picturepath_ = ""
        self.name_ = ''
        self.clearListView_music.emit()
        self.picturepath.emit('')
        self.name.emit('')
        self.picture.emit('test.jpg')
    
    @pyqtSlot()
    def save(self):
        """
        """
        # music.upd_playlist_list()
        # music.close_playlist_dialog()  
        print('save')

    @pyqtSlot()
    def set(self):
        """
        """
        self.set_data_()
        print('set')
    
    @pyqtSlot(int)
    def set_playlist(self, id_):
        print('upd_p ', id_)
        name = 'id_ ' + str(id_)
        self.picturepath_ = name
        self.picturepath_ = '...'
        self.picturepath.emit(self.picturepath_)
        self.picture.emit(self.picturepath_)


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