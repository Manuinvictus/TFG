import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import '../styles.css'; // Importa el archivo de estilos CSS global

const Login = () => {
    const [Username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const history = useNavigate();

    const Auth = async (e) => {
        e.preventDefault();
        try {
            const bodyParameters = {
                'name': Username,
                'password': password
            };
            const options = {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(bodyParameters)
            };
            const response = await fetch("/getUserByName", options);
            if (!response.ok) {
                throw new Error('Error en la solicitud');
            }else{
                history("/Home");
            }
        } catch (error) {
            console.error('Error al autenticar:', error);
            let div = document.getElementById("error");
            div.style.visibility = "visible";
        }
    };

    return (
        <div className="backgroundlogin"> {/* Aplica la clase backgroundlogin */}
            <div className="content"> {/* Aplica la clase content */}
                <div className="form-container"> {/* Aplica la clase form-container */}
                    <form onSubmit={Auth} className="login-form"> {/* Aplica la clase login-form */}
                        <h2>GESTOR DE FP</h2>
                        <label>Username</label>
                        <input type="text" placeholder="Username" value={Username} onChange={(e) => setUsername(e.target.value)} />
                        <label className="label">Password</label>
                        <input type="password" placeholder="******" value={password} onChange={(e) => setPassword(e.target.value)} />
                        <button>Login</button>
                        <div id="error" style={{ visibility: "hidden" }}>
                            <p>Contraseña o usuario equivocado, prueba de nuevo</p>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    );
};

export default Login;