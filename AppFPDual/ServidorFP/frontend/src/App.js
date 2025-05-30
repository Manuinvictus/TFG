import React from 'react';
import { BrowserRouter, Route, Routes } from "react-router-dom";

import Header from './components/Header'; // Importa el componente Header
import Home from "./components/Home";
import Footer from "./components/Footer";

import AddDualStudent from "./components/AddDualStudent";
import AddCompanyRequest from "./components/AddCompanyRequest";
import LinkStudents from "./components/LinkStudents";
import Login from "./components/Login";

import './styles.css'; // Importa el archivo de estilos CSS global
import 'bootstrap/dist/css/bootstrap.min.css';

function App() {
  return (
    <div className="app">
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<Login/>} /> 
          <Route path="/addDualStudent" element={<><Header/><AddDualStudent/><Footer/></>} /> 
          <Route path="/addCompanyRequest" element={<><Header/><AddCompanyRequest/><Footer/></>} /> 
          <Route path="/linkStudents" element={<><Header/><LinkStudents/><Footer/></>} /> 
          <Route path="/home" element={<><Header/><Home/><Footer/></>} /> 
        </Routes>
      </BrowserRouter>
    </div>
  );
}

export default App;