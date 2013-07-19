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
    public partial class RegisterOperation : Form
    {
        public RegisterOperation()
        {
            InitializeComponent();

            DBManager db = DBManager.getSingleton();
            Request request = new OcorrenciaTipoImprint().get();
            DataTable results = db.query(request).Tables[request.tableName];

            ControlUtils.FillComboBoxWithDataSet<OcorrenciaTipoComboBoxItem>(comboBox1, results);
        }

        private void button3_Click(object sender, EventArgs e)
        {
            DBManager db = DBManager.getSingleton();
            OcorrenciaImprint imprint = new OcorrenciaImprint();

            Request r = imprint.add(DateTime.Now,
                                    ((OcorrenciaTipoComboBoxItem)comboBox1.SelectedItem).id,
                                    Int32.Parse(textBox3.Text),
                                    Int32.Parse(textBox1.Text),
                                    textBox2.Text);
            DataTable results = db.execute(r).Tables[r.tableName];
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            PickSector form = new PickSector();
            this.Enabled = false;
            if (form.ShowDialog() == DialogResult.OK)
            {
                textBox1.Text = form.sector.piso+"";
                textBox2.Text = form.sector.zona;
                textBox3.Text = form.sector.inst+"";
            }
            this.Focus();
            this.Enabled = true;
        }

        public class OcorrenciaTipoComboBoxItem : ComboBoxItem
        {
            public Int32 id;
            public String nomeTipo;

            public override string ToString()
            {
                return nomeTipo;
            }

            public override ComboBoxItem inflate(DataTableReader reader)
            {
                id = reader.GetInt32(0);
                nomeTipo = reader.GetString(1);
                return this;
            }
        }
    }
}
