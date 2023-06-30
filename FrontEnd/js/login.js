function login(){
    const user = document.getElementById("usuario").value;
    const password = document.getElementById("contraseña").value;

    if(user=="leandro" && pass=="1234"){
        window.open=("../vcpregunta.html");
    } else {
        alert("Credenciales incorrectas")
    };
};