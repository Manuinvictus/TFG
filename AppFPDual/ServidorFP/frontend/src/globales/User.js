import { createContext, useContext, useState } from 'react';

// Creamos un contexto (es como un componente padre, que puede guardar valores que usen 
// todos los componentes que se encuentren envueltos en el mismo)
const UserContext = createContext();

export const User = ({ children }) => {
    const [user, setUser] = useState(null);

    const logout = (navigate) => {
        setUser(null);
        navigate('/login');
    };

    return (
        <UserContext.Provider value={{ user, setUser, logout }}>
            {children} 
        </UserContext.Provider>
    );
};

export const useUser = () => useContext(UserContext);