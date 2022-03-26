from peewee import *
import pandas as pd
import datetime
# pd.to_datetime(datetime.datetime.now())
music_db = SqliteDatabase('music.sqlite')
# Создаем курсор - специальный объект для запросов и получения данных с базы
# cursor = music_db.cursor()
# cursor.execute('''CREATE TABLE Playlist_Song (
#     track_id int,
#     playlist_id int,
#     FOREIGN KEY ("track_id") REFERENCES "Song" ("id"),
#     FOREIGN KEY ("playlist_id") REFERENCES "Playlist" ("id")
# );''')
# cursor.executescript("""
#  insert into Song values (Null, 'Aaa', 'bbb', '2000', 'fff', 'p', 300.33, True, 1, 'vvv','bbbmbhb');
# """)
# music_db.commit()
# cursor.execute("SELECT * FROM Song")
# results = cursor.fetchall()
# print(results) 
class BaseModel(Model):
    class Meta:
        database = music_db
        print('SqliteDatabase')
        # database = SqliteDatabase('music.sqlite')

class Song(BaseModel):
    song_id = AutoField(column_name='id')
    song_title = TextField(column_name = 'song_title')
    artist = TextField(column_name = 'artist')
    publish_year = TextField(column_name = 'publish_year')
    album = TextField(column_name = 'album')
    genre = TextField(column_name = 'genre')
    duration  = FloatField(column_name = 'duration')
    liked = BooleanField(column_name = 'liked')
    listened = IntegerField(column_name = 'listened')
    path_in_pc = TextField(column_name = 'path_in_pc')
    path_img = TextField(column_name = 'path_img')
    class Meta:
        table_name = 'Song'

class Playlist(BaseModel):
    playlist_id = AutoField(column_name='id')
    playlist_name = TextField(column_name = 'playlist_name')
    number_of_tracks = IntegerField(column_name = 'number_of_tracks')
    duration_playlist  = FloatField(column_name = 'duration_playlist')
    created_date = DateField(column_name = 'created_date')
    path_pl_img = TextField(column_name = 'path_pl_img')
    class Meta:
         table_name = 'Playlist'

class Playlist_Song(BaseModel):
    track_id = ForeignKeyField(Song) #column_name = 'track_id'
    playlist_id = ForeignKeyField(Playlist) #
    class Meta:
         table_name = 'Playlist_Song'



# import os, os.path
# pip install tinytag
# dirname1 = 'music/'
# files1 = os.listdir(dirname1)
# dirname2 = 'images/'
# files2 = os.listdir(dirname2)
# dirname3 = 'playlist_images/'
# files3 = os.listdir(dirname3)
# print(files3)

# from tinytag import TinyTag
# tag = TinyTag.get('music/' + 'Depeche Mode - Enjoy The Silence (Pitchugin Radio Remix).mp3')
# tag

# df = pd.DataFrame(columns= ['id','song_title','artist','publish_year','album','genre','duration','liked','listened','path_in_pc','path_img'])
# df
# for id_, (i, j) in enumerate(zip(files1,files2)):
#     tag = TinyTag.get('music/' + i)
#     df = df.append({'id':id_,'song_title':tag.title,'artist':tag.artist,
#                     'publish_year':tag.year,'album':tag.album,'genre':tag.genre,'duration':tag.duration,
#                     'liked':False,'listened':0,'path_in_pc':'music/' + i,'path_img':'images/' + j},ignore_index=True)
#     print(i,j)
# df
# l = ['2019','1990','2020','2011','2010','1991','2008','2016','2021','2015','2018','2015','2017','1992','1784']
# df.publish_year = l
# df.to_sql('Song',music_db,if_exists='append',index = False)
# t = Song.select().limit(5).dicts().execute()
# print(Song.select().limit(5).dicts())
# [i for i in t]

# import datetime
# pd.to_datetime(datetime.datetime.now())
# d = {'id': [1,2], 'playlist_name': ['Imagine Dragons','Rock'],'number_of_tracks':[6,8],'duration_playlist':[1325.958234,2035.636043],'created_date':pd.to_datetime(datetime.datetime.now()),'path_pl_img':['playlist_images/pl1.png', 'playlist_images/pl2.jpg']}
# playlists = pd.DataFrame(data=d)
# playlists
# playlists.to_sql('Playlist',music_db,if_exists='append',index = False)
# d2 = {'track_id':[7,8,9,10,11,12,  1,3,7,8,9,10,11,12],'playlist_id':[1,1,1,1,1,1, 2,2,2,2,2,2,2,2]}
# playlist_song = pd.DataFrame(data=d2)
# playlist_song
# playlist_song.to_sql('Playlist_Song',music_db,if_exists='replace',index = False)
# df.merge(playlist_song, how='left', left_on='id', right_on='track_id').dropna(subset=['playlist_id']).groupby('playlist_id').agg('count')
# for i in Playlist.select().dicts():
#     print(i)
# Playlist.select()


def get_all_music(Song):
    return pd.DataFrame(data = Song.select().dicts().execute())

def get_all_playlist(Playlist):
    return pd.DataFrame(data = Playlist.select().dicts().execute())

def get_song_in_playlist(Song, Playlist_Song, id_):
    alias_ = Song.alias('tmp_1')
    return pd.DataFrame(data = (Playlist_Song.select(Playlist_Song, alias_).join(alias_,  on = (Playlist_Song.track_id == alias_.id)).where(Playlist_Song.playlist_id == id_)).dicts().execute())

def set_favorite(Song, id_):
    alias_ = Song.alias()
    row = alias_.select().where(alias_.id == id_).get()
    row.liked = not row.liked
    row.save()


def add_new_song(Song,musicpath_,picturepath_,genre_,title_,album_,artistname_,duration_,year_):
    alias_ = Song.alias()
    max_n = alias_.select(fn.MAX(alias_.song_id)).dicts().get()['id'] + 1
    # data_ = {'album':album_,'artist':artistname_,'duration':duration_,'genre': genre_,'liked': False,\
    #      'listened': 0,'path_img':picturepath_,'path_in_pc':musicpath_,'publish_year':year_,'song_id': max_n,'song_title':title_}
    Song.insert(album = album_,artist = artistname_,duration = duration_, genre = genre_, liked = False,\
         listened = 0, path_img = picturepath_, path_in_pc = musicpath_, publish_year = year_,song_id = max_n, song_title = title_).execute() # 

def del_song_cascade(Song,Playlist_Song, id_):
    alias_ = Song.alias()
    row = alias_.select().where(alias_.id == id_).get()
    row.delete_instance()

    if id_ in pd.DataFrame( data = (Playlist_Song.select().dicts().execute())).track_id.to_list():
        alias_2 = Playlist_Song.alias()
        row2 = alias_2.select().where(alias_2.track_id == id_).get()
        row2.delete_instance()


def add_playlist(Playlist, Playlist_Song,picturepath_, playlist_name, list_checked_id, duration):
    alias_ = Playlist.alias()
    max_n = alias_.select(fn.MAX(alias_.id)).dicts().get()['id'] + 1
    print(max_n)
    Playlist.insert(id = max_n, playlist_name = playlist_name,duration_playlist = duration, number_of_tracks = len(list_checked_id),\
        path_pl_img = picturepath_, created_date = pd.to_datetime(datetime.datetime.now())).execute()

    for i in list_checked_id:
        Playlist_Song.insert(track_id = i, playlist_id = max_n).execute()

def del_playlist_cascade(Playlist, Playlist_Song, id_):
    alias_ = Playlist.alias()
    row = alias_.select().where(alias_.id == id_).get()
    row.delete_instance()
    
    if id_ in pd.DataFrame( data = (Playlist_Song.select().dicts().execute())).playlist_id.to_list():
        alias_2 = Playlist_Song.alias()
        row2 = alias_2.select().where(alias_2.playlist_id == id_).get()
        row2.delete_instance()

def get_playlist_info(Playlist, id_):
    alias_ = Playlist.alias()
    row = alias_.select().where(alias_.id == id_).dicts().get()
    return row 

def change_playlist_(Playlist, Playlist_Song, id_, picturepath_, playlist_name, list_checked_id, duration):
    data = get_song_in_playlist(Song, Playlist_Song, id_)
    alias_ = Playlist.alias()
    row = alias_.select().where(alias_.id == id_).get()
    row.playlist_name = playlist_name
    row.number_of_tracks = len(list_checked_id)
    row.duration_playlist = duration
    row.path_pl_img = picturepath_
    row.created_date = pd.to_datetime(datetime.datetime.now())

    alias_2 = Playlist_Song.alias()
    row2 = alias_2.select().where(alias_2.playlist_id == id_).get()
    row2.delete_instance()

    for i in list_checked_id:
        Playlist_Song.insert(track_id = i, playlist_id = id_).execute()

    
    

    
    
# add_playlist(Playlist, Playlist_Song,'111', '222', [1,2,3,4], 50)

# del_playlist_cascade(Playlist, Playlist_Song, 3)
# alias_ = Song.alias()
# alias_.select(fn.MAX(alias_.song_id)).dicts().get()['id']
# add_new_song(Song,'musicpath_','picturepath_','genre_','title_','album_','artistname_',33,'2267')
# del_song_cascade(Song, Playlist_Song, 15)


# alias_ = Song.alias()
# row = alias_.select().where(alias_.publish_year == 2267).get()
# row.delete_instance()
# alias_ = Playlist.alias()
# row = alias_.select().where(alias_.id == 1).dicts().get()
# print(row)
# data.id.to_list()
if  __name__ == "__main__":
    music_db.connect()
    print(get_all_music(Song))
# get_all_playlist(Playlist)
# get_song_in_playlist(Song, Playlist_Song, 2)
# set_favorite(Song, 1)
# add_new_song(Song,'musicpath_','picturepath_','genre_','title_','album_','artistname_',33,'2267')
# get_song_in_playlist(Song, Playlist_Song, 1)
# alias_ = Playlist_Song.alias()
# max_n = alias_.select(fn.MAX(alias_.song_id)).dicts().get()['id'] + 1
# data_ = {'album':album_,'artist':artistname_,'duration':duration_,'genre': genre_,'liked': False,\
#      'listened': 0,'path_img':picturepath_,'path_in_pc':musicpath_,'publish_year':year_,'song_id': max_n,'song_title':title_}
# for t in Playlist_Song.select().dicts().execute():
#     print(t)
# Playlist_Song.insert(track_id = 15, playlist_id = 1).execute()
