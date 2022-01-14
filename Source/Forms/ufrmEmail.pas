unit ufrmEmail;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ScrollBox,
  FMX.Memo, FMX.Edit, FMX.ListBox, FMX.StdCtrls, ACBrBase, ACBrMail,
  FMX.Effects, FMX.Filter.Effects, FMX.Objects, FMX.Controls.Presentation;

type
  TFrmEmail = class(TForm)
    rect_titulo: TRectangle;
    lblTitulo: TLabel;
    rectRodapé: TRectangle;
    rectSalvar: TRoundRect;
    lblSalvar: TLabel;
    imgSalvar: TImage;
    FillRGBEffect1: TFillRGBEffect;
    rectLimpar: TRoundRect;
    lblLimpar: TLabel;
    imgLimpar: TImage;
    FillRGBEffect2: TFillRGBEffect;
    ACBrMail: TACBrMail;
    GbxConfig: TGroupBox;
    cbxProvedor: TComboBox;
    edtemailOrigem: TEdit;
    edtSenha: TEdit;
    Label2: TLabel;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    edtfrom: TEdit;
    Label4: TLabel;
    edtAssunto: TEdit;
    Label5: TLabel;
    memCorpo: TMemo;
    Label6: TLabel;
    edtAnexo: TEdit;
    procedure rectSalvarClick(Sender: TObject);
    procedure rectLimparClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEmail: TFrmEmail;

implementation

{$R *.fmx}

uses ufrmCadastro;

procedure TFrmEmail.FormCreate(Sender: TObject);
var
 caminho,arquivo:string;
begin
  memCorpo.Text := frmCadastro.ConteudoEmail.Text;
   Arquivo       := 'cadastro.xml';
   caminho       := ExtractFilePath(ParamStr(0));

  edtAnexo.Text := Caminho + Arquivo;
end;

procedure TFrmEmail.rectLimparClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFrmEmail.rectSalvarClick(Sender: TObject);

begin

  ACBrMail.Clear;
  ACBrMail.IsHTML   := true;
  ACBrMail.Subject  := edtAssunto.Text;
  ACBrMail.From     := edtemailOrigem.text;
  ACBrMail.FromName := 'Info';

  //Configurações
  case cbxProvedor.ItemIndex of
   0: begin
     ShowMessage('Atenção escolha um provedor antes de Continuar! ');
     Abort
   end;
   1: begin
     ACBrMail.Host     := 'smtp.office365.com';
     ACBrMail.Username :=  edtemailOrigem.Text;
     ACBrMail.Password :=  edtSenha.Text;
     ACBrMail.Port     :=  '587' ;
     ACBrMail.SetTLS   :=  true;
     ACBrMail.SetSSL   :=  false;
   end;
   2: begin
     ACBrMail.Host     := 'smtp.live.com';
     ACBrMail.Username :=  edtemailOrigem.Text;
     ACBrMail.Password :=  edtSenha.Text;
     ACBrMail.Port     :=  '587' ;
     ACBrMail.SetTLS   :=  true;
     ACBrMail.SetSSL   :=  false;
   end;
   3: begin
     ACBrMail.Host     := 'smtp.gmail.com';
     ACBrMail.Username :=  edtemailOrigem.Text;
     ACBrMail.Password :=  edtSenha.Text;
     ACBrMail.Port     :=  '587' ;
     ACBrMail.SetTLS   :=  true;
     ACBrMail.SetSSL   :=  true;
   end;
  end;

  ACBrMail.AddAddress(edtfrom.Text,'');
  ACBrMail.Body.Assign(memCorpo.Lines);

  ACBrMail.AddAttachment(edtAnexo.Text);

  try
   ACBrMail.Send(false);
   ShowMessage('Email enviado com sucesso!');
   frmCadastro.rectLimpar.OnClick(Sender);
   Self.Close;
  except
   ShowMessage('Erro ao enviar email');
   exit
  end;

end;

end.
