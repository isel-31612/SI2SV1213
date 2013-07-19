using System.Windows.Forms;
using System.Data;

namespace Utils
{
    public class ControlUtils
    {
        public static void FillComboBoxWithDataSet<T>(ComboBox comboBox, DataTable results) where T : ComboBoxItem,new()
        {
            comboBox.Items.Clear();
            using (DataTableReader reader = results.CreateDataReader())
            {
                while (reader.Read())
                {
                    comboBox.Items.Add(new T().inflate(reader));
                }
            }
        }
    }
}
