# import sys
# # Класс QUrl предоставляет удобный интерфейс для работы с Urls
# from PyQt5.QtCore import QUrl
# from PyQt5.QtWidgets import QApplication, QWidget
# # Класс QQuickView предоставляет возможность отображать QML файлы.
# from PyQt5.QtQuick import QQuickView


# if __name__ == '__main__':
#     app = QApplication(sys.argv)

#     # Объект QQuickView, в который грузится UI для отображения
#     view = QQuickView()
#     view.setSource(QUrl('test_1/main.qml'))
#     view.show()
#     app.exec_()
#     sys.exit()


from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot
import pandas as pd
import  add_file
import change_playlist
import datetime


d = {'id_playlist': [1, 1, 1, 1, 1, 2, 2, 2], 'id_music': [1, 2, 3, 4, 5, 3 , 6, 2]}
playlists_music = pd.DataFrame(data=d)

d2 = {'id': [1,2], 'playlist_name': ['Imagine Dragons','Rock'],'number_of_tracks':[6,8],'duration_playlist':[1325.958234,2035.636043],'created_date':pd.to_datetime(datetime.datetime.now()),'path_pl_img':['playlist_images/pl1.png', 'playlist_images/pl2.jpg']}
playlists = pd.DataFrame(data=d2)

music = pd.read_csv('course_project/music.csv')

class Music(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.playlists = playlists
        self.pause_ = False
        self.music = music
        self.playlists_music = playlists_music       


    
    seekSlider = pyqtSignal(int, arguments=['longer_'])
    seekSlider2 = pyqtSignal(int, arguments=['longer_2'])

    updListView_music = pyqtSignal()
    addListView_music = pyqtSignal(int,str,str,str,bool, arguments=['id_','author_','publish_year_','track_','liked_'])
    dropListView_music =  pyqtSignal(int, arguments=['id'])
    clearListView_music = pyqtSignal()

    updListView_playlist = pyqtSignal()
    addListView_playlist = pyqtSignal(int, str, int, int, arguments=['id_','name_','num_music_','duration_'])
    dropListView_playlist = pyqtSignal(int, arguments=['id'])
    clearListView_playlist = pyqtSignal()

    updListView_Now_playlist = pyqtSignal()
    addListView_Now_playlist = pyqtSignal(int,str,str,str,bool, arguments=['id_','author_','publish_year_','track_','liked_'])
    dropListView_Now_playlist =  pyqtSignal(int, arguments=['id'])
    clearListView_Now_playlist = pyqtSignal()

    closeDialog1 = pyqtSignal()
    closeDialog2 = pyqtSignal()

    def set_data_(self):
        if not self.music.empty:
            for i, row in self.music.iterrows():
                self.addListView_music.emit(row.id, row.artist,str(row.publish_year),row.song_title, row.liked)
        
        if not self.playlists.empty:
            for i, row in self.playlists.iterrows():
                self.addListView_playlist.emit(row.id, row.playlist_name, row.number_of_tracks, int(row.duration_playlist/60))
        

    @pyqtSlot()
    def get_all_music(self):
        """
        """
        print('get_all_music')
        # return self.music.
        self.updListView_music.emit()

    @pyqtSlot()
    def get_all_playlists(self):
        """
        """
        print('get_all_playlists')
        self.updListView_playlist.emit()

    def get_music_in_playlist(self, num_):
        df = self.playlists_music.loc[self.playlists_music['id_playlist'] == num_].join(self.music, lsuffix="_left", on='id_music')
        self.clearListView_Now_playlist.emit()
        for i, row in df.iterrows():
            self.addListView_Now_playlist.emit(row.id, row.artist,str(row.publish_year),row.song_title, row.liked) 
    
    @pyqtSlot()
    def get_now_playlists(self):
        """
        """
        print('get_all_playlists')
        self.updListView_Now_playlist.emit()

    @pyqtSlot(int)
    def set_now_playlists(self,id_):
        """
        """
        print('set_now_playlists', id_)
        self.get_music_in_playlist(id_)
        # self.updListView_Now_playlist.emit()

    
    @pyqtSlot()
    def play(self):
        # складываем два аргумента и испускаем сигнал
        # self.sumResult.emit(arg1 + arg2)
        print('play')
        self.seekSlider2.emit(10)
        self.test_()
    
 
    @pyqtSlot()
    def pause(self):
        """
        """
        if not self.pause_:
            print('pause')
            self.pause_ = not  self.pause_ 
        else:
            print('unpause')
            self.pause_ = not  self.pause_ 
    
    @pyqtSlot()
    def stop(self):
        """
        """
        print('stop')

    @pyqtSlot()
    def next(self):
        """
        """
        print('next')
    
    @pyqtSlot()
    def previous(self):
        """
        """
        print('previous')


    @pyqtSlot()
    def repeat(self):
        """
        """
        print('repeat')
        # self.seekSlider.emit(500)
    
    @pyqtSlot()
    def shuffle(self):
        """
        """
        print('shuffle')
        # self.seekSlider.emit(500)

    @pyqtSlot()
    def favorite(self):
        """
        """
        print('favorite')
        
    @pyqtSlot(str,int)
    def change_music(self, a,b):
        """
        """
        print(a)
        print('change_ ' + a,b)
        # self.seekSlider.emit(100) 

    @pyqtSlot()
    def start_file_dialog(self):
        """
        """
        print('start_file_dialog')

    @pyqtSlot()
    def upd_music_list(self):
        """
        """
        print('upd_music_list ' + 'add')
        self.closeDialog1.emit()
        
    @pyqtSlot()
    def close_music_dialog(self):
        self.closeDialog1.emit()

    @pyqtSlot()
    def close__playlist_dialog(self):
        self.closeDialog2.emit()

if  __name__ == "__main__":
    import sys
 
    # создаём экземпляр приложения
    app = QGuiApplication(sys.argv)
    # создаём QML движок
    engine = QQmlApplicationEngine()
    music_add = add_file.Music_Add()
    playlist_change = change_playlist.playlist_change()
    # создаём объект
    music = Music()
    # и регистрируем его в контексте QML
    engine.rootContext().setContextProperty("playlist_change", playlist_change)
    engine.rootContext().setContextProperty("music_add", music_add)
    engine.rootContext().setContextProperty("music", music)
    # загружаем файл qml в движок
    engine.load("course_project/main.qml")
    music.set_data_()
    # music.addListView_music.emit()
    engine.quit.connect(app.quit)
    sys.exit(app.exec_())

