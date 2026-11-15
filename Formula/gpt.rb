class Gpt < Formula
  desc "Compiler, interpreter and C translator for the G-Portugol language"
  homepage "https://github.com/gportugol/gpt"
  license "GPL-2.0-or-later"
  head "https://github.com/gportugol/gpt.git", branch: "master"

  depends_on "antlr" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "antlr4-cpp-runtime"
  depends_on "pcre2"

  on_linux do
    depends_on "nasm"
  end

  def install
    runtime = Formula["antlr4-cpp-runtime"]
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", *std_configure_args,
           "ANTLR4_CMD=#{formula_opt_bin("antlr")}/antlr",
           "ANTLR4_INC=-isystem #{runtime.opt_include}/antlr4-runtime",
           "ANTLR4_LIB=-L#{runtime.opt_lib} -lantlr4-runtime"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"ola.gpt").write <<~EOS
      algoritmo ola;
      início
        imprima("Olá Mundo!");
      fim
    EOS
    assert_equal "Olá Mundo!\n", shell_output("#{bin}/gpt -i ola.gpt")

    system bin/"gpt", "-t", "ola.c", "ola.gpt"
    system ENV.cc, "-o", "ola_c", "ola.c"
    assert_equal "Olá Mundo!\n", shell_output("./ola_c")

    if OS.linux? && Hardware::CPU.intel?
      system bin/"gpt", "-o", "ola", "ola.gpt"
      assert_equal "Olá Mundo!\n", shell_output("./ola")
    end
    if OS.mac? && Hardware::CPU.arm?
      system bin/"gpt", "-o", "ola", "ola.gpt"
      assert_equal "Olá Mundo!\n", shell_output("./ola")
    end
  end
end
