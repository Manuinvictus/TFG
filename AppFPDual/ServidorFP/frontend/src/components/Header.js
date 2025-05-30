import { Link } from 'react-router-dom';

function Header() {

  return (
    <div>
      <header>
        <nav className="navbar navbar-expand-lg px-3">
          <Link to="/" className="navbar-brand d-flex align-items-center">
            <img
              src="https://salesianosrioja.com/wp-content/uploads/2016/03/Logo-Salesianos_vertical.png"
              alt="Logo"
              style={{ width: '80px', height: '50px', marginRight: '15px' }}
            />
            <span className="fs-4 fw-bold">GESTOR DE FP DUAL</span>
          </Link>
          <div className="collapse navbar-collapse justify-content-end">
            <ul className="navbar-nav">
              <li className="nav-item">
                <Link to="/home" className="nav-link fw-bold text-white">HOME</Link>
              </li>
              <li className="nav-item">
                <Link to="/addDualStudent" className="nav-link fw-bold text-white">ALUMNOS</Link>
              </li>
              <li className="nav-item">
                <Link to="/addCompanyRequest" className="nav-link fw-bold text-white">EMPRESAS</Link>
              </li>
              <li className="nav-item">
                <Link to="/linkStudents" className="nav-link fw-bold text-white">ENLAZAR</Link>
              </li>
              <li className="nav-item">
                <Link to="/" className="nav-link fw-bold">LOGOUT</Link>
              </li>
            </ul>
          </div>
        </nav>
      </header>
    </div>
  );
}

export default Header;