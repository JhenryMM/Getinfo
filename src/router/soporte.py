from flask import Blueprint, render_template, request, current_app, flash, current_app
from flask_login import login_required, current_user
from models.ModelUser import ModelUser
from utils.utils import roles_required
from models.entities.User import User

soporte = Blueprint('soporte',__name__)


@soporte.route('/crear_soporte', methods = ['POST','GET'])
@login_required
@roles_required(['soporte'])
def crear_soporte():
    db = current_app.db 
    if request.method == 'POST':
        username = request.form.get('username')
        fullname = request.form.get('fullname')
        password = request.form.get('password')
        esadmi = 1 if request.form.get('esadmin') == 'si' else 0

        if username is None and password is None and len(username) > 255:
            flash('Nombre de usuario vacio', 'danger')
            return redirect(url_for('crear_soporte'))
        
        if ModelUser.es_usuario(username, db) or ModelUser.es_soporte(username, db):
             flash('Usuario existe, vuelva a registrar', 'danger')
        else:    
            password_hash = User.generar_hash(password)
            user = User(0, username, password_hash, fullname," " ,esadmi)
            ModelUser.crear_soporte(user, db)
            flash('Cuenta creada!')
        
    return render_template('auth/crearsoporte.html')