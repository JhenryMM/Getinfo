from flask import Blueprint, render_template
from flask_login import login_required

pregunta = Blueprint('pregunta', __name__)

@pregunta.route('/vcpregunta')
@login_required
def vcpregunta():
    return render_template('auth/vcpregunta.html')
