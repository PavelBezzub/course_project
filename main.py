from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QObject, pyqtSignal, pyqtSlot
import pandas as pd
import  add_file
import change_playlist
import datetime
from music_db_ import *
from pygame import mixer

import threading
import time

class Progressbar:
      
    def __init__(self, signal,func, position = 0):
#         self.mixer = mixer
        self._running = True
        self.func = func
        self.position = position
        self.signal = signal

    def terminate(self):
        self._running = False
        print('terminate')

    def run(self): # , n
        i = 0
        print('run')
        time.sleep(1)
        while self._running and mixer.music.get_busy():
            # print('i :',self.position + mixer.music.get_pos()/ 1000)
#             i += 1
            self.signal(self.position + mixer.music.get_pos()/ 1000)
            time.sleep(1)
        if self._running: 
#             next_music()
            self.func()


class Music(QObject):
    def __init__(self):
        QObject.__init__(self)
        # self.song_table = music_db_.Song()
        # self.playlist_table = music_db_.Playlist()
        # self.playlist_song_table = music_db_.Playlist_Song()

        self.playlists = get_all_playlist(Playlist)
        # self.pause_ = False
        self.music = get_all_music(Song)
        # self.playlists_music = playlists_music  
        self.mixer_ = mixer.init() 

        
        # self.path_py = os.path.abspath(os.curdir) + '\\'
        # self.current_music = '' 
        # self.current_playlist = None  
        # self.now_playlist = None

        ################################################ для плэйлиста
        self.pause_ = False
        self.current_playlist = None 
        self.volume = 0.5
        self.music_count = 0
        self.current_music_id = 0
        self.next_music_id = 1
        self.previous_music_id = 0
    # seekSlider.to
    
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


    setProperty_music_list = pyqtSignal(int,str, bool, arguments=['id_','property_','liked_'])
    setProperty_now_music_list = pyqtSignal(int,str, bool, arguments=['id_','property_','liked_'])


    set_songNameLabel = pyqtSignal(str, arguments=['text_'])
    set_main_picture = pyqtSignal(str, arguments=['path_'])

    def set_data_(self):
        if not self.music.empty:
            for i, row in self.music.iterrows():
                self.addListView_music.emit(row.song_id, row.artist,str(row.publish_year),row.song_title, row.liked)
        
        if not self.playlists.empty:
            for i, row in self.playlists.iterrows():
                self.addListView_playlist.emit(row.playlist_id, row.playlist_name, row.number_of_tracks, int(row.duration_playlist/60))
        

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

    @pyqtSlot()
    def get_now_playlists(self):
        """
        """
        print('get_now_playlists')
        self.updListView_Now_playlist.emit()


    def get_music_in_playlist(self, id_):
        """
        """
        df = get_song_in_playlist(Song, Playlist_Song, id_)
        # self.current_playlist = df.reset_index()
        self.clearListView_Now_playlist.emit()
        for i, row in df.iterrows():
            self.addListView_Now_playlist.emit(row.id, row.artist,str(row.publish_year),row.song_title, row.liked) 
        return df.reset_index()
    


    @pyqtSlot(int)
    def set_now_playlists(self,id_):
        """
        """
        print('set_now_playlists', id_)
        
        self.current_playlist = self.get_music_in_playlist(id_)
        self.music_count = (self.current_playlist.shape[0])
        # print(self.current_playlist)
        # print(self.music_count)
        # self.updListView_Now_playlist.emit()
    def test_f(self,pos):
        self.seekSlider2.emit(pos)

    @pyqtSlot()
    def play(self):
        """
        """
        print('play')
        info = self.current_playlist.loc[self.current_music_id]
        print(info)
        self.set_songNameLabel.emit(info.song_title)
        self.set_main_picture.emit(info.path_img)
        print('duration ', info.duration)
        self.seekSlider.emit(info.duration)
        self.seekSlider2.emit(0) # сигнал на слайдер
        mixer.music.load(info.path_in_pc)
        mixer.music.set_volume(self.volume)
        mixer.music.play()
        self.progress = Progressbar(self.test_f, self.next_)
        self.thread_ = threading.Thread(target = self.progress.run)
        self.thread_.start()
        if self.next_music_id < self.music_count - 1:
            self.next_music_id = self.current_music_id + 1
        # self.mixer_.load()
        # self.seekSlider2.emit(10)
        # self.test_()

    @pyqtSlot(int)
    def play_all_music(self,id_):
        
        self.current_playlist = get_all_music(Song)
        self.music_count = (self.current_playlist.shape[0])
        self.current_music_id = id_
        if id_ > 0:
            self.previous_music_id = id_ - 1
        print('play all music', id_)
        # self.set_songNameLabel.emit('play')

    @pyqtSlot(int)
    def play_music_in_playlist(self,id_):

        print('play_music_in_playlist', id_)
    
 
    @pyqtSlot()
    def pause(self):
        """
        """
        if not self.pause_:
            self.progress.terminate() 
            self.thread_.join() 
            
            mixer.music.pause()
            print('pause')
            self.pause_ = not self.pause_ 
        else:
            # self.progress.terminate() 
            # self.thread_.join() 
            mixer.music.unpause()
            print('unpause')
            self.pause_ = not self.pause_ 
            self.progress = Progressbar(self.test_f, self.next_)
            self.thread_ = threading.Thread(target = self.progress.run)
            self.thread_.start()
    
    @pyqtSlot()
    def stop(self):
        """
        """
        self.progress.terminate() 
  
        # Wait for actual termination (if needed) 
        self.thread_.join() 
        mixer.music.stop()

        print('stop')

    @pyqtSlot()
    def next_(self):
        """
        """
        self.pause_ = False
        self.progress.terminate() 
  
        self.thread_.join()
        mixer.music.stop()
        if self.current_music_id < self.music_count - 1:
            self.current_music_id += 1
            self.play()
        else:
            print('the playlist is over')
                
        print('next')
    
    @pyqtSlot()
    def previous(self):
        """
        """
        self.progress.terminate() 
  
        self.thread_.join()
        mixer.music.stop()
        if self.current_music_id == 0 :
#             self.current_music_id += 1
            self.play()
        else:
            self.current_music_id -= 1
            self.play()
        print('previous')

    @pyqtSlot()
    def repeat(self):
        """
        """
        self.next_music_id = self.current_music_id
        print('repeat')
    
    @pyqtSlot()
    def shuffle(self):
        """
        """
        print('shuffle')

    @pyqtSlot()
    def pressed(self):
        """
        """
        print('pressed')

    @pyqtSlot()
    def released(self):
        """
        """
        print('released')

    @pyqtSlot(int)
    def rewind_music(self, position):
        """
        """
        self.progress.terminate() 
  
        self.thread_.join()
        mixer.music.stop()
        print('rewind ', position)
        mixer.music.rewind()
#         mixer.music.set_pos(float(t))
        mixer.music.play(start = position)
        # self.progress = Progressbar(self.test_f, self.next_,  position = position)
        # self.thread_ = threading.Thread(target = self.progress.run)
        # self.thread_.start()
    
    @pyqtSlot()
    def favorite(self):
        """
        """
        print('favorite')
        # self.setProperty_music_list.emit(1,'favorite',True)
        # self.setProperty_now_music_list.emit(1,'favorite',True)
        info = self.current_playlist.loc[self.current_music_id]
        id_ = info.id
        self.change_music('favorite like', id_, False)
        # self.set_main_picture.emit('test_.jpg')

    @pyqtSlot(int)
    def set_volume(self, x):
        """
        """
        print('set_volume ', x)
        self.volume = x
        mixer.music.set_volume(float(self.volume/100))
    

    @pyqtSlot(str,int, bool)
    def change_music(self, a,id_,flag):
        """
        """
        print('change_ ' + a,id_, not flag)
        print('current_playlist', self.current_playlist.columns())
        if a == 'like':
            if (self.current_playlist is not None):
                if (id_ in self.current_playlist.id.to_list()):
                    t = self.current_playlist.loc[self.current_playlist.id == id_].index.values[0]
                    self.setProperty_now_music_list.emit(t,'favorite',not flag)
            set_favorite(Song, id_)

        if a == 'like now playlist':
            t = self.music.loc[self.music.song_id == id_].index.values[0]
            print('t ', t)
            self.setProperty_music_list.emit(t,'favorite',not flag)
            set_favorite(Song, id_)

        if a == 'favorite like':
            if (self.current_playlist is not None):
                if (id_ in self.current_playlist.id.to_list()):
                    t = self.current_playlist.loc[self.current_playlist.id == id_].index.values[0]
                    self.setProperty_now_music_list.emit(t,'favorite',not flag)

            t = self.music.loc[self.music.song_id == id_].index.values[0]
            self.setProperty_music_list.emit(t,'favorite',not flag)

    @pyqtSlot()
    def start_file_dialog(self):
        """
        """
        print('start_file_dialog')

    @pyqtSlot()
    def upd_music_list(self):
        """
        """
        self.music = get_all_music(Song)
        self.clearListView_music.emit()
        for i, row in self.music.iterrows():
            self.addListView_music.emit(row.song_id, row.artist,str(row.publish_year),row.song_title, row.liked)
        print('upd_music_list ' + 'add')
        # self.closeDialog1.emit()

    @pyqtSlot()
    def upd_playlist_list(self):
        """
        """
        print('upd_playlist_list ')
        # self.closeDialog2.emit()
        
    @pyqtSlot()
    def close_music_dialog(self):
        self.closeDialog1.emit()

    @pyqtSlot()
    def close_playlist_dialog(self):
        self.closeDialog2.emit()

    @pyqtSlot(int)
    def del_music(self, id_):
        print('delete music ', id_)
        del_song_cascade(Song,Playlist_Song, id_)
        self.upd_music_list()

if  __name__ == "__main__":
    import sys
    import os
    print(os.path.abspath(os.curdir))
    # создаём экземпляр приложения
    app = QGuiApplication(sys.argv)
    # создаём QML движок
    engine = QQmlApplicationEngine()
    music_add = add_file.Music_Add()
    playlist_change = change_playlist.playlist_change()
    # создаём объект
    # music_db.init('music.sqlite')
    music = Music()
    # и регистрируем его в контексте QML
    engine.rootContext().setContextProperty("playlist_change", playlist_change)
    engine.rootContext().setContextProperty("music_add", music_add)
    engine.rootContext().setContextProperty("music", music)
    # загружаем файл qml в движок
    engine.load("main.qml")
    music.set_data_()
    # music.addListView_music.emit()
    engine.quit.connect(app.quit)
    sys.exit(app.exec_())

