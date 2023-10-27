from flask import Flask, render_template, request, redirect, url_for, flash
from config import config
from flask_mysqldb import MySQL
from flask_wtf.csrf import CSRFProtect
from flask_login import LoginManager, login_user, login_required, logout_user
from router.pregunta import pregunta


#Carpetamodels:
from models.ModelUser import ModelUser

#entities:
from models.entities.User import User

app = Flask(__name__)

csrf=CSRFProtect()
db=MySQL(app)
login_manager_app = LoginManager(app)


@login_manager_app.user_loader
def load_user(id):
    return ModelUser.get_by_id(db, id)


@app.route('/')
def index():
    return redirect(url_for('login'))

@app.route('/signup', methods=['POST', 'GET'])
def signup_create():
    if request.method == 'POST':
        username = request.form.get('username')
        fullname = request.form.get('fullname')
        password = request.form.get('password')

        if username is None:
            flash('Nombre de usuario vacio', 'danger')
            return redirect(url_for('signup_create'))

        if password is None:
            flash('Contraseña no proporcionada', 'danger')
            return redirect(url_for('signup_create'))

        password_hash = User.generar_hash(password)
        user = User(0, username, password_hash, fullname)

        if len(user.username) > 255:
            flash('Nombre de usuario demasiado largo', 'danger')
            return redirect(url_for('signup_create'))

        if ModelUser.verificar_usuario(user, db):
            flash('Usuario existe, vuelva a registrarse o inicie sesión', 'danger')
            return redirect(url_for('signup_create'))
        else:
            ModelUser.crear_usuario(user, db)
            return redirect(url_for('login'))
    return render_template('auth/registro.html')

 
@app.route('/login', methods=['GET','POST'])    
def login():
    if request.method == 'POST':
        user = User(0, request.form['username'], request.form['password'])
        logged_user = ModelUser.login(db, user)
        if logged_user != None:
            if logged_user:
                login_user(logged_user)
                return redirect(url_for('pregunta.vcpregunta'))
            else:
                flash("contraseña incorrecta...")
            return render_template ('auth/login.html')
        else:
            flash("Usuario no existente...")
            return render_template ('auth/login.html')

        return render_template('auth/login.html')
    else:
        return render_template('auth/login.html')

@app.route('/logout')
def logout():
    logout_user()
    return redirect(url_for('login'))

def status_401(error):
    return redirect(url_for('login'))

def status_404(error):
    return "<h1> Página no encontrada </h1>", 404

if __name__=='__main__':
    app.config.from_object(config['development'])
    csrf.init_app(app)
    app.register_error_handler(401,status_401)
    app.register_error_handler(404,status_404)
    app.register_blueprint(pregunta, url_prefix='/pregunta')
    app.run()

