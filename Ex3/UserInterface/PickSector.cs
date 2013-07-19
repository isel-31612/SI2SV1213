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
    public partial class PickSector : Form
    {
        public SectorComboBoxItem sector;
        private DBManager db;
        private Request request;

        public PickSector()
        {
            InitializeComponent();
            db = DBManager.getSingleton();
            request = new SectorImprint().get();
            DataTable results = db.query(request).Tables[request.tableName];
            
            ControlUtils.FillComboBoxWithDataSet<SectorComboBoxItem>(comboBox1,results);
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.Cancel;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            sector = (SectorComboBoxItem)comboBox1.SelectedItem;
            this.DialogResult = DialogResult.OK;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            DataTable results = db.execute(request).Tables[request.tableName];//TODO Should get from database

            ControlUtils.FillComboBoxWithDataSet<SectorComboBoxItem>(comboBox1, results);
        }

        public class SectorComboBoxItem : ComboBoxItem
        {
            public String descr;
            public String zona;
            public Int32 piso;
            public Int32 inst;

            public override string ToString()
            {
                return descr;
            }

            public override ComboBoxItem inflate(DataTableReader reader)
            {
                descr = reader.GetString(3);
                zona = reader.GetString(1);
                piso = reader.GetInt32(0);
                inst = reader.GetInt32(2);
                return this;
            }
        }
    }
}
