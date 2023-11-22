$(document).ready(function () {
    $('#mostrarUsuariosBtn').on('click', function (event) {
        event.preventDefault();

        fetch('/obtener_soporte')
            .then(response => response.json())
            .then(data => {
                const listaUsuarios = document.getElementById('listaUsuarios');
                listaUsuarios.innerHTML = '';

                data.forEach(usuario => {
                    const tr = document.createElement('tr');

                    const tdIdusuario = document.createElement('td');
                    tdIdusuario.textContent = usuario[0];

                    const tdNombredeusuario = document.createElement('td');
                    tdNombredeusuario.textContent = usuario[2];

                    const tdNombrecompleto = document.createElement('td');
                    tdNombrecompleto.textContent = usuario[1];

                    const tdEsAdmin = document.createElement('td');
                    tdEsAdmin.textContent = usuario[3] === 1 ? 'Sí' : 'No';

                    const tdBoton_modificar = document.createElement('td');
                    const btn_m = document.createElement('button');
                    btn_m.textContent = 'Cambiar contraseña';
                    btn_m.classList.add('btn', 'btn-primary');
                    btn_m.addEventListener('click', function (e) {
                        console.log('Botón de cambiar contraseña clickeado');
                        const fila = e.target.closest('tr');
                        const tdUsuarioId = fila.querySelector('td:first-child');
                        const usuarioId = tdUsuarioId.textContent;
                        console.log(usuarioId);
                        console.log('Usuario ID:', usuarioId);
                        console.log('Nueva Contraseña:', nuevaContrasena);
                        $('#modalCambiarContrasena').modal('show');

                        // Enviar los datos actualizados al hacer clic en "Guardar Cambios"
                        $('#formCambiarContrasena').on('submit', function (event) {
                            event.preventDefault();

                            const nuevaContrasena = $('#nuevaContrasena').val();
                            const csrfToken = $('input[name=csrf_token]').val();

                            console.log('Usuario ID:', usuarioId);
                            console.log('Nueva Contraseña:', nuevaContrasena);

                            // Enviar la nueva contraseña al servidor
                            fetch(`/contrasena_soporte/${usuarioId}`, {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json',
                                    'X-CSRFToken': csrfToken
                                },
                                body: JSON.stringify({ nuevaContrasena: nuevaContrasena })
                            })

                            .then(response => {
                                if (!response.ok) {
                                    throw new Error('Network response was not ok');
                                }
                                return response.json();
                            })
                            .then(data => { 
                                console.log('Response data:', data); // Verificar si se obtiene la respuesta del servidor
                                
                            })
                            .catch(error => {
                                console.error('Error during fetch:', error);
                                // Aquí se puede agregar un mensaje de error específico o cualquier acción de manejo de errores necesaria
                            });

                            $('#modalCambiarContrasena').modal('hide');
                            $('#modalConfirmacion').modal('show');
                        });


                    });

                    tdBoton_modificar.appendChild(btn_m);

                    const tdBoton_eliminar = document.createElement('td');
                    const btn_e = document.createElement('button');
                    btn_e.textContent = 'eliminar';
                    btn_e.classList.add('btn', 'btn-primary');
                    btn_e.addEventListener('click', function () {
                        window.location.href = `/otro_endpoint/${usuario.id}`;
                    });

                    tdBoton_eliminar.appendChild(btn_e);
                    tr.appendChild(tdIdusuario);
                    tr.appendChild(tdNombredeusuario);
                    tr.appendChild(tdNombrecompleto);
                    tr.appendChild(tdEsAdmin);
                    tr.appendChild(tdBoton_modificar);
                    tr.appendChild(tdBoton_eliminar);

                    listaUsuarios.appendChild(tr);
                });
            })
            .catch(error => {
                console.error('Error:', error);
            });
    });
});
