class LibtorchPrebuildAT111 < Formula
  desc "Tensors and dynamic neural networks"
  homepage "https://pytorch.org/"
  url "https://download.pytorch.org/libtorch/cpu/libtorch-macos-1.11.0.zip"
  sha256 "27bb17e6ea35e2cb12d388f54319b4e2b80e7532c1ce2b2f6903c1753365c3ef"
  license "BSD-3-Clause"

  def install
    system "bash", "-c", "cd include/torch; for i in csrc/api/include/torch/* ; do ln -s $i ;done"
    system "bash", "-c", "install -d #{include}"
    system "bash", "-c", "install -d #{lib}"
    system "bash", "-c", "install -d #{share}"
    system "bash", "-c", "cp -a include/* #{include}"
    system "bash", "-c", "cp -a lib/* #{lib}"
    system "bash", "-c", "cp -a share/* #{share}"
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
