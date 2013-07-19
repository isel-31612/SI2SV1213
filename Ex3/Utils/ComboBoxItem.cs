using System.Data;

namespace Utils
{
    public abstract class ComboBoxItem
    {
        public override abstract string ToString();

        public abstract ComboBoxItem inflate(DataTableReader reader);
    }
}
