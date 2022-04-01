from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot
from isodate import Duration
from matplotlib.artist import Artist
import pandas as pd
from tinytag import TinyTag

from music_db_ import *


class playlist_change(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.picturepath_ = ''
        self.name_ = ''
        # self.music_ = get_all_music(Song)
        # self.quantity_ = self.music_.shape[0]
        self.change_ = False

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
                self.addListView_music.emit(row.song_id, row.artist,str(row.publish_year),row.song_title, row.liked, row.add_)
    
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
    def change_music(self, a,b,flag):
        """
        """
        self.music_.loc[self.music_.song_id == b, 'add_'] = flag
        print('change_ ' + a,b,flag)

    @pyqtSlot()
    def clear(self):
        """
        """
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
        if self.change_:
            # change_playlist(Playlist, Playlist_Song, id_, picturepath_, playlist_name, list_checked_id, duration)
            list_checked_id = self.music_.loc[self.music_['add_']].song_id.to_list()
            duration = self.music_.loc[self.music_.add_].duration.sum()
            change_playlist_(Playlist, Playlist_Song, self.id_, self.picturepath_, self.name_, list_checked_id, duration)
            print('c')
        else:
            list_checked_id = self.music_.loc[self.music_['add_']].song_id.to_list()
            duration = self.music_.loc[self.music_.add_].duration.sum()
            add_playlist(Playlist, Playlist_Song,self.picturepath_, self.name_, list_checked_id, duration)
        # music.upd_playlist_list()
        # music.close_playlist_dialog()  
        print('save')

    @pyqtSlot()
    def set_all(self):
        """
        """
        data = get_all_music(Song)
        data['add_'] = False
        self.music_ = data
        self.quantity_ = self.music_.shape[0]
        self.set_data_()
        print('set')
    
    @pyqtSlot(int)
    def set_playlist(self, id_):
        """
        """
        self.id_ = id_
        all_data = get_all_music(Song)
        s = get_song_in_playlist(Song, Playlist_Song, id_).song_id.to_list()
        all_data['add_'] = False
        all_data.loc[all_data.song_id.isin(s), 'add_'] = True
        self.music_ = all_data
        self.set_data_()
        self.quantity_ = self.music_.shape[0]

        self.change_ = True
        print('upd_p ', id_)
        info = get_playlist_info(Playlist, id_)
        print(info)
        self.name_ = info['playlist_name']
        self.picturepath_ = info['path_pl_img']
        self.name.emit(self.name_)
        self.picturepath.emit(self.picturepath_)
        self.picture.emit(self.picturepath_)

#         {'playlist_id': 2,
#  'playlist_name': 'Rock',
#  'number_of_tracks': 8,
#  'duration_playlist': 2035.636043,
#  'created_date': datetime.date(2022, 3, 17),
#  'path_pl_img': 'playlist_images/pl2.jpg'}

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