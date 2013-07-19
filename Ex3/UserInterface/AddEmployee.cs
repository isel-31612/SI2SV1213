using AccessModel;
using DomailModel;
using DomainModel;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Utils;

namespace UserInterface
{
    public partial class AddEmployee : Form
    {
        public AddEmployee()
        {
            InitializeComponent();
            Request r = new EmployeeTipoImprint().get();
            DBManager db = DBManager.getSingleton();
            DataTable results = db.query(r).Tables[r.tableName];

            ControlUtils.FillComboBoxWithDataSet<EmployeeTypeComboBoxItem>(comboBox1, results);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        public class EmployeeTypeComboBoxItem : ComboBoxItem
        {
            public Int32 id;
            public String nomeEstado;

            public override string ToString()
            {
                return nomeEstado;
            }

            public override ComboBoxItem inflate(DataTableReader reader)
            {
                id = reader.GetInt32(0);
                nomeEstado = reader.GetString(1);
                return this;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            DBManager db = DBManager.getSingleton();
            EmployeeImprint imprint = new EmployeeImprint();

            Request r = imprint.add(
                textBox1.Text,
                dateTimePicker1.Value,
                ((EmployeeTypeComboBoxItem)comboBox1.SelectedItem).id
            );
            DataTable results = db.execute(r).Tables[r.tableName];
            this.Close();

        }
    }
}
