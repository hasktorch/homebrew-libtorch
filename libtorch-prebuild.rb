class LibtorchPrebuild < Formula
  desc "Tensors and dynamic neural networks"
  homepage "https://pytorch.org/"
  url "https://download.pytorch.org/libtorch/cpu/libtorch-macos-1.6.0.zip"
  sha256 "e1140bed7bd56c26638bae28aebbdf68e588a9fae92c6684645bcdd996e4183c"
  license "BSD-3-Clause"

  bottle :unneeded

  def install
    system "pwd"
    system "ls"
    system "make", "install", "DESTDIR=#{prefix}"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <torch/torch.h>
      #include <iostream>

      int main() {
        torch::Tensor tensor = torch::rand({2, 3});
        std::cout << tensor << std::endl;
      }
    EOS
    system ENV.cxx, "-std=c++14", "-L#{lib}", "-ltorch", "-ltorch_cpu", "-lc10", "test.cpp", "-o", "test"
    system "./test"
  end
end
