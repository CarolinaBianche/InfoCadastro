unit ufrmCadastro;

interface

uses
  info.Classe.Pessoa,
  info.funcoes,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Edit,
  System.ImageList, FMX.ImgList, FMX.Effects, FMX.Filter.Effects, Xml.xmldom,
  Xml.XMLIntf, Xml.XMLDoc, ACBrBase, ACBrMail,System.MaskUtils;

type
  TfrmCadastro = class(TForm)
    lytGeral: TLayout;
    rect_titulo: TRectangle;
    lblTitulo: TLabel;
    gbx_dadoscadastrais: TGroupBox;
    edtNome: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtRG: TEdit;
    Label3: TLabel;
    edtCpf: TEdit;
    Label4: TLabel;
    edtTelefone: TEdit;
    Label5: TLabel;
    edtemail: TEdit;
    Gbx_endereco: TGroupBox;
    edtCep: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    edtLogradouro: TEdit;
    Label8: TLabel;
    edtBairro: TEdit;
    Label9: TLabel;
    edtCidade: TEdit;
    Label10: TLabel;
    edtEstado: TEdit;
    Label11: TLabel;
    edtPais: TEdit;
    Label12: TLabel;
    edtNumero: TEdit;
    Label13: TLabel;
    edtComplemento: TEdit;
    rectRodap�: TRectangle;
    rectSalvar: TRoundRect;
    lblSalvar: TLabel;
    imgSalvar: TImage;
    FillRGBEffect1: TFillRGBEffect;
    rectLimpar: TRoundRect;
    lblLimpar: TLabel;
    imgLimpar: TImage;
    FillRGBEffect2: TFillRGBEffect;
    rectConcluir: TRoundRect;
    lblConcluir: TLabel;
    imgConcluir: TImage;
    FillRGBEffect3: TFillRGBEffect;
    rectEmail: TRoundRect;
    lblEmail: TLabel;
    imgEmail: TImage;
    FillRGBEffect4: TFillRGBEffect;
    procedure FormCreate(Sender: TObject);
    procedure rectSalvarClick(Sender: TObject);
    procedure edtCepChange(Sender: TObject);
    procedure rectLimparClick(Sender: TObject);
    procedure rectEmailClick(Sender: TObject);
    procedure rectConcluirClick(Sender: TObject);
    procedure edtCpfKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtRGKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtTelefoneKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtCepKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    FConteudoEmail: TstringList;
    { Private declarations }
    procedure ValidaCampos;
    procedure LimpaCampos;
    procedure MontaEmail;
    procedure FecharCadastro;
    procedure SetConteudoEmail(const Value: TstringList);
    procedure MascaraTexto(const AEdit :TEdit;const Mask:string);

  public
    { Public declarations }
    property ConteudoEmail :TstringList read FConteudoEmail write SetConteudoEmail;
  end;

var
  frmCadastro: TfrmCadastro;

implementation

{$R *.fmx}

uses uDmRest, ufrmEmail, ufrmLogin;

procedure TfrmCadastro.edtCepChange(Sender: TObject);
var Lista: TStringList;
    CepLimpo:string;
    i:integer;
begin
  if Length(edtCep.Text)=9 then
   begin
     Lista := TStringList.Create;
     CepLimpo:= LimpaString('-',edtCep.Text);
     Lista := DmRest.RecebeCep(CepLimpo);
     if Lista.Count >0 then
     Begin
       edtCep.Text        := Lista.Strings[0];
       edtLogradouro.Text := Lista.Strings[1];
       edtComplemento.Text:= Lista.Strings[2];
       edtBairro.Text     := Lista.Strings[3];
       edtCidade.Text     := Lista.Strings[4];
       edtEstado.Text     := Lista.Strings[5];
       edtNumero.SetFocus;
     End else
     ShowMessage('Cep n�o localizado!');

   end;

end;

procedure TfrmCadastro.edtCepKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
 MascaraTexto(Sender as TEdit,'99999-999');
end;

procedure TfrmCadastro.edtCpfKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  MascaraTexto(Sender as TEdit,'999.999.999-99');
end;

procedure TfrmCadastro.edtRGKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  MascaraTexto(Sender as TEdit,'99.999.999-9');
end;

procedure TfrmCadastro.edtTelefoneKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
 MascaraTexto(Sender as TEdit,'(99)99999-9999');
end;

procedure TfrmCadastro.FecharCadastro;
begin
 FrmLogin.Tag  := 0;
 FrmLogin.rectAcessar.Visible:= true;
 FrmLogin.rectFechar.Visible := true;
 self.Close;
end;

procedure TfrmCadastro.FormCreate(Sender: TObject);
begin
 lytGeral.Opacity := 0;
 lytGeral.AnimateFloat('Opacity', 1, 0.9);
end;

procedure TfrmCadastro.LimpaCampos;
begin
  edtNome.Text       := EmptyStr;
  edtRG.Text         := EmptyStr;
  edtCPF.Text        := EmptyStr;
  edtTelefone.Text   := EmptyStr;
  edtEmail.Text      := EmptyStr;
  edtCep.Text        := EmptyStr;
  edtLogradouro.Text := EmptyStr;
  edtNumero.Text     := EmptyStr;
  edtComplemento.Text:= EmptyStr;
  edtBairro.Text     := EmptyStr;
  edtCidade.Text     := EmptyStr;
  edtEstado.Text     := EmptyStr;
  edtPais.Text       := EmptyStr;
  Self.Tag           :=0;
end;

procedure TfrmCadastro.MascaraTexto(const AEdit: TEdit; const Mask: string);
var
  LAux :string;
begin
  if (AEdit.MaxLength<>Mask.Length) then
    AEdit.MaxLength := Mask.Length;

    LAux := AEdit.Text.Replace('.','',[rfReplaceAll]);
    LAux := LAux.Replace('-','',[rfReplaceAll]);
    LAux := LAux.Replace('/','',[rfReplaceAll]);
    LAux := LAux.Replace('(','',[rfReplaceAll]);
    LAux := LAux.Replace(')','',[rfReplaceAll]);
    LAux := FormatMaskText(Mask+';0;_',LAux).Trim;

    for var I:Integer := LAux.Length-1 downto 0 do
      if not CharInSet(LAux.Chars[i],['0'..'9']) then
        delete(LAux, I+1,1)
        else
        Break;

   TEdit(AEdit).Text := LAux;
   TEdit(AEdit).GoToTextEnd;

end;

procedure TfrmCadastro.MontaEmail;
begin
 ConteudoEmail := TStringList.Create;
 ConteudoEmail.Add('<html>');
 ConteudoEmail.Add('<head>');
 ConteudoEmail.Add('<meta http-equiv="content-type" content="text/html; charset=UTF-8"> ');
 ConteudoEmail.Add('</head>');
 ConteudoEmail.Add('<body text="#000000" bgcolor="#FFFFFF"> ');
 ConteudoEmail.Add('   <h1>Cadastro Info Sistemas #info7Dias</h1>');
 ConteudoEmail.Add('   <br />                    ');
 ConteudoEmail.Add('   <p>Dados do Cadastro</p/>');
 ConteudoEmail.Add('   <p>                       ');
 ConteudoEmail.Add('Nome : '+ edtNome.Text + '<br />');
 ConteudoEmail.Add('Identidade : '+ edtRG.Text + '- CPF:' + edtCpf.Text+ '<br />');
 ConteudoEmail.Add('Telefone   : '+ edtTelefone.Text + '<br />');
 ConteudoEmail.Add('Email   : '+ edtemail.Text + '<br />');
 ConteudoEmail.Add('   <p>Dados do Endere�o</p/>');
 ConteudoEmail.Add('Cep   : '+ edtcep.Text + '<br />');
 ConteudoEmail.Add('Logradouro : '+ edtLogradouro.Text +','+ edtNumero.Text + '-' + edtComplemento.Text + '<br />');
 ConteudoEmail.Add(' '+ edtBairro.Text +' '+ edtCidade.Text + ' -' + edtEstado.Text +'- ' + edtPais.Text + '<br />');
 ConteudoEmail.Add('   </p>                       ');
 ConteudoEmail.Add('</body>');
 ConteudoEmail.Add('</html>');
end;

procedure TfrmCadastro.rectConcluirClick(Sender: TObject);
begin
 if Self.Tag= 0  then
  Begin
     MessageDlg('Voc� ainda n�o gravou os dadaos do Cadastro. Deseja realmente sair ?', System.UITypes.TMsgDlgType.mtInformation,
      [System.UITypes.TMsgDlgBtn.mbYes,System.UITypes.TMsgDlgBtn.mbNo], 0,
      procedure(const AResult: System.UITypes.TModalResult)
       begin
       case AResult of
       mrYES:begin
               FecharCadastro;
             end;
       mrNo:begin
             abort
            end;
       end;
      end);
  End else
  Begin
  FecharCadastro;
  End;

end;

procedure TfrmCadastro.rectEmailClick(Sender: TObject);
begin
  if not Assigned(FrmEmail) then
      Application.CreateForm(TFrmEmail,frmEmail);


  frmEmail.ShowModal;

end;

procedure TfrmCadastro.rectLimparClick(Sender: TObject);
begin
  LimpaCampos;
end;

procedure TfrmCadastro.rectSalvarClick(Sender: TObject);
var DadosPessoa   : TPessoa;
    DadosEndereco : TEndereco;
    vresult : String;
begin

  self.ValidaCampos;

  try
   DadosEndereco := TEndereco.Create;
    Try
     DadosEndereco.Cep        := edtCep.text;
     DadosEndereco.Logradouro := edtLogradouro.Text;
     DadosEndereco.Numero     := edtNumero.Text;
     DadosEndereco.Complemento:= edtComplemento.Text;
     DadosEndereco.Bairro     := edtBairro.Text;
     DadosEndereco.Cidade     := edtCidade.Text;
     DadosEndereco.Estado     := edtEstado.Text;
     DadosEndereco.Pais       := edtPais.Text;
    Except
      ShowMessage('Erro ao carregar os Dados de Endere�o.');
      exit
    End;
   DadosPessoa  := TPessoa.Create;
   Try
    DadosPessoa.Nome       := edtNome.Text;
    DadosPessoa.Identidade := edtRG.Text;
    DadosPessoa.CPF        := edtCpf.Text;
    DadosPessoa.Telefone   := edtTelefone.Text;
    DadosPessoa.Email      := edtemail.Text;
    DadosPessoa.Endereco   := DadosEndereco;
   except
    ShowMessage('Erro ao carregar os Dados da Pessoa ');
    exit
   End;

   if DadosPessoa.Set_Pessoa(DadosPessoa,vresult) then
    Self.Tag := 1;

  finally
    if Assigned(DadosEndereco) then
      FreeAndNil(DadosEndereco);
    if Assigned(DadosPessoa) then
      FreeAndNil(DadosPessoa);

    MessageDlg('Cadastro realizado com Sucesso.Deseja enviar um Email ?', System.UITypes.TMsgDlgType.mtInformation,
      [System.UITypes.TMsgDlgBtn.mbYes,System.UITypes.TMsgDlgBtn.mbNo], 0,
      procedure(const AResult: System.UITypes.TModalResult)
       begin
       case AResult of
       mrYES:begin
              MontaEmail;
              rectEmail.OnClick(Sender);
             end;
       mrNo:begin
             MontaEmail;
             ShowMessage('Cadastro Realizado com Sucesso');
            end;
       end;
      end);

  end;

end;



procedure TfrmCadastro.SetConteudoEmail(const Value: TstringList);
begin
  FConteudoEmail := Value;
end;

procedure TfrmCadastro.ValidaCampos;
begin
  if edtNome.Text.IsEmpty then
    Begin
      ShowMessage('Preencha o Nome antes de Continuar');
      abort
    End;

  if edtCpf.Text.IsEmpty then
    Begin
      ShowMessage('Preencha o CPF antes de Continuar');
      abort
    End;

  if edtCep.Text.IsEmpty then
    Begin
      ShowMessage('Preencha o Cep antes de Continuar');
      abort
    End;

  if edtNumero.Text.IsEmpty then
    Begin
      ShowMessage('Preencha o Numero antes de Continuar');
      abort
    End;
end;

end.
