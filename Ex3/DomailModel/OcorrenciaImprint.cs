using DomainModel;
using System;

namespace DomailModel
{
    public class OcorrenciaImprint : Imprint
    {
        private static String table = "Ocorrencia";
        public Request add(DateTime entryDate,Int32 type,int inst, int piso, String zona)
        {
            return new AddRequest(
                table,
                null,
                new Tuple<String,Object>[] {
                    new Tuple<String,Object>("entrada",entryDate),
                    new Tuple<String,Object>("ultimaActualizacao",entryDate),
                    new Tuple<String,Object>("tipo",type),
                    new Tuple<String,Object>("secInst",inst),
                    new Tuple<String,Object>("secPiso",piso),
                    new Tuple<String,Object>("secZona",zona)});
        }

        public Request get(int id)
        {
            return new GetRequest(table, null, new Tuple<String,Object>[] { new Tuple<String,Object>("id",id) });
        }

        public Request replace(int id, DateTime entryDate, String type, int inst, int piso, String zona)
        {
            return new EditRequest(
                table,
                null,
                new Tuple<String,Object>[] {
                    new Tuple<String,Object>("id",id),
                    new Tuple<String,Object>("entrada",entryDate),
                    new Tuple<String,Object>("ultimaActualizacao",entryDate),
                    new Tuple<String,Object>("tipo",type),
                    new Tuple<String,Object>("secInst",inst),
                    new Tuple<String,Object>("secPiso",piso),
                    new Tuple<String,Object>("secZona",zona)});
        }

        public Request remove(int id)
        {
            return new RemoveRequest(table, null, new Tuple<String, Object>[] { new Tuple<String, Object>("id", id) });
        }
    }
}
