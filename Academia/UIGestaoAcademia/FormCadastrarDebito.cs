﻿using BLL;
using Models;


namespace UIGestaoAcademia
{
    public partial class FormCadastrarDebito : Form
    {
        int id;
        public FormCadastrarDebito(int _id = 0)
        {
            InitializeComponent();
            id = _id;


            if (id == 0)
                bindingSourceCadastrarDebito.AddNew();
            else
                bindingSourceCadastrarDebito.DataSource = new ControleDebitoBLL().BuscarPorId(_id);
        }
        private void buttonSalvar_Click_1(object sender, EventArgs e)
        {
            try
            {
                bindingSourceCadastrarDebito.EndEdit();
                ControleDebito controleDebito = (ControleDebito)bindingSourceCadastrarDebito.Current;

                //TODO: Apagar a linha abaixo
                controleDebito.Cliente = new Cliente() { Id = 12, Nome = "Maria" };

                if (id == 0)
                    new ControleDebitoBLL().Inserir(controleDebito);
                else
                    new ControleDebitoBLL().Alterar(controleDebito);

                MessageBox.Show("Registro salvo com sucesso!");
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void buttonBuscarFormaPagamento_Click(object sender, EventArgs e)
        {
            using (FormConsultaFormaPagamento frm = new FormConsultaFormaPagamento())
            {
                frm.ShowDialog();
                ((ControleDebito)bindingSourceCadastrarDebito.Current).FormaPagamento = frm.FormaPagamento;
                ((ControleDebito)bindingSourceCadastrarDebito.Current).FormaPagamentoId = frm.FormaPagamento.Id;
                textBoxFormaDePagamento.Text = frm.FormaPagamento.Descricao;
            }
        }
    }
}
