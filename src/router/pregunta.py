from flask import Blueprint, render_template, request
from flask_login import login_required

pregunta = Blueprint('pregunta', __name__)

@pregunta.route('/vcpregunta', methods = ['POST','GET'])
@login_required
def vcpregunta():
    if request.method == 'POST':
        problema = request.form['problema']
        print(problema)
        return render_template('auth/vcpregunta.html')
    else:
        return render_template('auth/vcpregunta.html')
