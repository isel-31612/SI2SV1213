using DomainModel;

namespace DomailModel
{
    public class OcorrenciaTipoImprint : Imprint
    {
        public Request get()
        {
            return new GetRequest("Tipo",
                                  "SELECT id,nomeTipo FROM Tipo",
                                  null);
        }
    }
}
