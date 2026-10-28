import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário de Cadastro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
          brightness: Brightness.light,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
      home: const FormularioCadastroScreen(),
    );
  }
}

class FormularioCadastroScreen extends StatefulWidget {
  const FormularioCadastroScreen({super.key});

  @override
  State<FormularioCadastroScreen> createState() => _FormularioCadastroScreenState();
}

class _FormularioCadastroScreenState extends State<FormularioCadastroScreen> {
  // Chave global do formulário
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controladores dos campos
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController = TextEditingController();

  // Estados para exibição de senha (Desafio)
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    _confirmaSenhaController.dispose();
    super.dispose();
  }

  void _submeterFormulario() {
    // Fecha o teclado virtual
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      // 5. Sucesso: Exibir SnackBar de confirmação
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle_rounded, color: Colors.white, size: 28),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Cadastro realizado com sucesso!',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } else {
      // Desafio: SnackBar de erro em vermelho quando campos forem inválidos
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.error_outline_rounded, color: Colors.white, size: 28),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Por favor, corrija os erros no formulário antes de continuar.',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // 7. Estrutura obrigatória:
    // Scaffold -> Form(key: _formKey) -> SingleChildScrollView -> Column -> TextFormFields + ElevatedButton
    // Aplicando boas práticas de responsividade (flutter-build-responsive-layout):
    // Centralização e limitação de largura (ConstrainedBox) para telas grandes/web.
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Cadastro de Usuário',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: const Color(0xFF1E293B),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Cabeçalho visual
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E88E5).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person_add_alt_1_rounded,
                          size: 48,
                          color: Color(0xFF1E88E5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Crie sua conta',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Preencha todos os campos obrigatórios abaixo:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // 1. Campo: Nome completo
                    TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome completo *',
                        hintText: 'Digite seu nome completo',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por favor, insira seu nome completo.';
                        }
                        if (value.trim().length < 3) {
                          return 'O nome deve ter no mínimo 3 caracteres.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // 2. Campo: E-mail
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'E-mail *',
                        hintText: 'exemplo@dominio.com',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por favor, insira seu e-mail.';
                        }
                        // Regra básica: deve conter @
                        if (!value.contains('@')) {
                          return 'O e-mail deve conter o caractere @.';
                        }
                        // Desafio: Validação mais robusta com RegExp
                        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value.trim())) {
                          return 'Por favor, insira um e-mail válido (ex: usuario@email.com).';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // 3. Campo: CPF
                    TextFormField(
                      controller: _cpfController,
                      decoration: const InputDecoration(
                        labelText: 'CPF (somente números) *',
                        hintText: '00000000000',
                        prefixIcon: Icon(Icons.badge_outlined),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por favor, insira o CPF.';
                        }
                        if (value.length != 11) {
                          return 'O CPF deve ter exatamente 11 dígitos numéricos.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // 4. Campo: Telefone
                    TextFormField(
                      controller: _telefoneController,
                      decoration: const InputDecoration(
                        labelText: 'Telefone (somente números) *',
                        hintText: 'DDD + Número (ex: 62999998888)',
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Por favor, insira o telefone.';
                        }
                        if (value.length < 10 || value.length > 11) {
                          return 'O telefone deve conter DDD + número (10 ou 11 dígitos).';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // 5. Campo: Senha
                    TextFormField(
                      controller: _senhaController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Senha *',
                        hintText: 'Mínimo de 6 caracteres',
                        prefixIcon: const Icon(Icons.lock_outline),
                        // Desafio: Botão para mostrar/ocultar senha
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: Colors.grey.shade600,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira uma senha.';
                        }
                        if (value.length < 6) {
                          return 'A senha deve ter no mínimo 6 caracteres.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // 6. Campo: Confirmação de Senha (Desafio)
                    TextFormField(
                      controller: _confirmaSenhaController,
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        labelText: 'Confirmar Senha *',
                        hintText: 'Repita a senha digitada',
                        prefixIcon: const Icon(Icons.lock_reset_outlined),
                        // Desafio: Botão para mostrar/ocultar confirmação de senha
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: Colors.grey.shade600,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, confirme sua senha.';
                        }
                        if (value != _senhaController.text) {
                          return 'As senhas não coincidem.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 28),

                    // 7. Botão CADASTRAR
                    ElevatedButton(
                      onPressed: _submeterFormulario,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E88E5),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'CADASTRAR',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
