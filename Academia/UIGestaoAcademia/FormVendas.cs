﻿using BLL;
using Models;

namespace UIGestaoAcademia
{
    public partial class FormVendas : Form
    {
        public FormVendas()
        {
            InitializeComponent();
        }
        private void buttonBuscarCliente_Click(object sender, EventArgs e)
        {            
                try
                {
                    using (FormConsultaCliente frm = new FormConsultaCliente())
                    {
                        frm.ShowDialog();

                        if (frm.Cliente != null)
                        {
                            ((Vendas)itensVendaBindingSource.Current).Cliente = frm.Cliente;
                            textBoxBuscarPorCliente.Text = frm.Cliente.Nome;
                        }
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }           
        }

        private void buttonBuscarFuncionario_Click(object sender, EventArgs e)
        {
            try
            {
                using (FormBuscarFuncionario frm = new FormBuscarFuncionario())
                {
                    frm.ShowDialog();

                    if (frm.Funcionario != null)
                    {
                        ((Vendas)itensVendaBindingSource.Current).Funcionario = frm.Funcionario;
                        textBoxBuscarFuncionario.Text = frm.Funcionario.Nome;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        private void buttonFormaDePagamento_Click(object sender, EventArgs e)
        {

        }
    }
}
