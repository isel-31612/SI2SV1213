using DomainModel;
using System;

namespace DomailModel
{
    public class EmployeeImprint : Imprint
    {
        public Request add(string name, DateTime birthdate, int state)
        {
            return new AddRequest(
                "Funcionario",
                "INSERT INTO Funcionario (nome,dataNasc,estado) VALUES(?,?,?)",
                new Tuple<String, Object>[]{
                    new Tuple<String,Object>("nome",name),
                    new Tuple<String,Object>("dataNasc",birthdate),
                    new Tuple<String,Object>("estado",state),
                });
        }
    }
}
