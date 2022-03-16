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
# import player
 
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


d = {'id_playlist': [1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3], 'id_music': [1, 2, 3, 4, 5, 3 , 6, 2, 1,3,5,6]}
playlists = pd.DataFrame(data=d)
d2 = {'id_music': [1, 2, 3, 4, 5, 6, 7], 'len_music': [5,6,4,8,10,7,6], 'name' : ['a','b','c','d','e','f','g']}
music = pd.DataFrame(data=d2)

class Music(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.playlists = playlists
        self.music = music
    
    seekSlider = pyqtSignal(int, arguments=['longer_'])
    seekSlider2 = pyqtSignal(int, arguments=['longer_2'])


    updListView_playlist = pyqtSignal(int, arguments=['len'])
    updListView_music = pyqtSignal(int, arguments=['len'])
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
    
    @pyqtSlot()
    def next(self):
        # складываем два аргумента и испускаем сигнал
        # self.sumResult.emit(arg1 + arg2)
        print('next')
        self.seekSlider.emit(500)

    @pyqtSlot()
    def get_all_music(self):
        """
        """
        print('get_all_music')
        # return self.music.
        self.updListView_music.emit(10)

    @pyqtSlot()
    def get_all_playlists(self):
        """
        """
        print('get_all_playlists')
        # return self.playlists.id_playlist
        self.updListView_playlist.emit(40)
 
    # слот для вычитания двух чисел
    @pyqtSlot()
    # def pause(self, arg1, arg2):
    def pause(self):
        # вычитаем аргументы и испускаем сигнал
        # self.subResult.emit(arg1 - arg2)
        
        print('pause')
        self.seekSlider.emit(100)

    @pyqtSlot(str,int)
    def change_(self, a,b):
        # вычитаем аргументы и испускаем сигнал
        # self.subResult.emit(arg1 - arg2)
        print(a)
        print('change_ ' + a,b)
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
    engine.rootContext().setContextProperty("music", music)
    # загружаем файл qml в движок
    engine.load("test_1/main.qml")
 
    engine.quit.connect(app.quit)
    sys.exit(app.exec_())

