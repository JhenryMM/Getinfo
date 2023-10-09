from .entities.User import User
from werkzeug.security import check_password_hash, generate_password_hash

class ModelUser():

    @classmethod
    def login(self,db,user):
        try:
            cursor = db.connection.cursor()
            sql= """SELECT id, username, password, fullname FROM usuario
             WHERE username = '{}'""".format(user.username)
            cursor.execute(sql)
            row = cursor.fetchone()
            if row != None:
                user = User(row[0], row[1], User.check_password(row[2],user.password), row[3])
                return user
            else:
                return None
        except Exception as ex:
            raise Exception(ex)

    @classmethod
    def verificar_usuario(cls,user,db ):
        try:
            cursor =db.connection.cursor()
            sql="""SELECT username FROM usuario
             WHERE username = '{}' """.format(user.username)
            cursor.execute(sql)
            row = cursor.fetchone()
            if row == None:
                return False
            else:
                return True
        except Exception as ex:
            raise Exception(ex)

    @classmethod
    def crear_usuario(cls, user, db):
        try:
            cursor = db.connection.cursor()
            sql = """INSERT INTO `getinfo`.`usuario` (`username`, `password`, `fullname`)
                    VALUES ('{}', '{}', '{}')""".format(user.username, user.password, user.fullname)
            cursor.execute(sql)
            cursor.close()
            db.connection.commit()
        except Exception as ex:
            raise Exception(ex)
    
    @classmethod
    def get_by_id(cls, db, id):
        try:
            cursor = db.connection.cursor()
            sql = """SELECT id, username, fullname FROM usuario WHERE id= {} """.format(id)
            cursor.execute(sql)
            row = cursor.fetchone()
            if row != None:
                return User(row[0], row[1], None, row[2])
            else : 
                return None
            cursor.close()
            
        except Exception as ex:
            raise Exception(ex)
    
