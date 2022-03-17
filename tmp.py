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
 
# class Calculator(QObject):
#     def __init__(self):
#         QObject.__init__(self)
 
#     # cигнал передающий сумму
#     # обязательно даём название аргументу через arguments=['sum']
#     # иначе нельзя будет его забрать в QML
#     sumResult = pyqtSignal(int, arguments=['sum'])
 
#     subResult = pyqtSignal(int, arguments=['sub'])
 
#     # слот для суммирования двух чисел
#     @pyqtSlot(int, int)
#     def sum(self, arg1, arg2):
#         # складываем два аргумента и испускаем сигнал
#         self.sumResult.emit(arg1 + arg2)
 
#     # слот для вычитания двух чисел
#     @pyqtSlot(int, int)
#     def sub(self, arg1, arg2):
#         # вычитаем аргументы и испускаем сигнал
#         self.subResult.emit(arg1 - arg2)


d = {'id_playlist': [1, 1, 1, 1, 1, 2, 2, 2], 'id_music': [1, 2, 3, 4, 5, 3 , 6, 2]}
playlists = pd.DataFrame(data=d)
# d2 = {'id_music': [1, 2, 3, 4, 5, 6, 7], 'len_music': [5,6,4,8,10,7,6], 'name' : ['a','b','c','d','e','f','g']}
# music = pd.DataFrame(data=d2)
music = pd.read_csv('music.csv')

class Music(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.playlists = playlists
        self.music = music
        # self.test_()
        


    
    seekSlider = pyqtSignal(int, arguments=['longer_'])
    seekSlider2 = pyqtSignal(int, arguments=['longer_2'])


    updListView_playlist = pyqtSignal()
    addListView_playlist = pyqtSignal(int, arguments=['len'])
    dropListView_playlist = pyqtSignal(int, arguments=['len'])
    clearListView_playlist = pyqtSignal()

    updNow_playlist = pyqtSignal()
    addNow_playlist = pyqtSignal(int, arguments=['len'])
    dropNow_playlist =  pyqtSignal(int, arguments=['len'])
    clearNow_playing = pyqtSignal()


    # updListView_music = pyqtSignal(int, arguments=['len'])

    updListView_music = pyqtSignal()
    addListView_music = pyqtSignal(int,str,str,str,bool, arguments=['id_','author_','publish_year_','track_','liked_'])
    dropListView_music =  pyqtSignal(int, arguments=['len'])
    clearListView_music = pyqtSignal()

    def test_(self):
        for i, row in self.music.head().iterrows():
            print(i)
            self.addListView_music.emit(row.id, row.artist,str(row.publish_year),row.song_title, row.liked) 
        
    # cигнал передающий сумму
    # обязательно даём название аргументу через arguments=['sum']
    # иначе нельзя будет его забрать в QML
    # sumResult = pyqtSignal(int, arguments=['sum'])
 
    # subResult = pyqtSignal(int, arguments=['sub'])
 
    # слот для суммирования двух чисел
    @pyqtSlot()
    def play(self):
        # складываем два аргумента и испускаем сигнал
        # self.sumResult.emit(arg1 + arg2)
        print('play')
        self.seekSlider2.emit(10)
        self.test_()
    
    @pyqtSlot()
    def next(self):
        # складываем два аргумента и испускаем сигнал
        # self.sumResult.emit(arg1 + arg2)
        print('next')
        # self.seekSlider.emit(500)

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
        # return self.playlists.id_playlist
        self.updListView_playlist.emit()
 
    # слот для вычитания двух чисел
    @pyqtSlot()
    # def pause(self, arg1, arg2):
    def pause(self):
        # вычитаем аргументы и испускаем сигнал
        # self.subResult.emit(arg1 - arg2)
        
        print('pause')
        # self.seekSlider.emit(100)

    @pyqtSlot(str,int)
    def change_(self, a,b):
        # вычитаем аргументы и испускаем сигнал
        # self.subResult.emit(arg1 - arg2)
        print(a)
        print('change_ ' + a,b)
        # self.seekSlider.emit(100) 

    @pyqtSlot()
    def start_file_dialog(self):

        # add_file_.run()
        print('a')
        # вычитаем аргументы и испускаем сигнал
        # self.subResult.emit(arg1 - arg2)
        # self.seekSlider.emit(100)
 

if  __name__ == "__main__":
    import sys
 
    # создаём экземпляр приложения
    app = QGuiApplication(sys.argv)
    # создаём QML движок
    engine = QQmlApplicationEngine()
    # создаём объект калькулятора
    music = Music()
    # и регистрируем его в контексте QML
    music_add = add_file.Music_Add()
    engine.rootContext().setContextProperty("music_add", music_add)
    engine.rootContext().setContextProperty("music", music)
    # загружаем файл qml в движок
    engine.load("main.qml")
    music.test_()
    # music.addListView_music.emit()
    engine.quit.connect(app.quit)
    sys.exit(app.exec_())

