from flask import Blueprint, render_template, request, current_app
from flask_login import login_required, current_user
from models.ModelUser import ModelUser

pregunta = Blueprint('pregunta', __name__)


@pregunta.route('/vcpregunta', methods = ['POST','GET'])
@login_required
def vcpregunta():
    db = current_app.db 
    user_id = current_user.id

    if request.method == 'POST':
        problema = request.form['problema']
        cursor = db.connection.cursor()
        sql = """INSERT INTO `getinfo`.`pregunta` (`descripcion`,`idusuario`) VALUES
        ('{}','{}')""".format(problema, user_id)
        cursor.execute(sql)
        cursor.close()
        db.connection.commit()
        print(problema)
        return render_template('auth/vcpregunta.html')
    else:
        return render_template('auth/vcpregunta.html')

@pregunta.route('/vspregunta', methods = ['POST','GET'])
@login_required
def vspregunta():
    db = current_app.db 
    user_id = current_user.id
    preguntas = []  # Lista para almacenar las preguntas

    try:
        cursor = db.connection.cursor()
        sql = """SELECT descripcion FROM pregunta """
        cursor.execute(sql)
        preguntas = [row[0] for row in cursor.fetchall()]  # Obtener todas las descripciones de las preguntas
    except Exception as ex:
        raise Exception(ex)

    return render_template('auth/vspregunta.html', preguntas=preguntas)