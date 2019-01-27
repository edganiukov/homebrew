class JdtLs < Formula
  desc "A Java language specific implementation of the Language Server Protocol"
  homepage "https://github.com/eclipse/eclipse.jdt.ls"

  url "http://download.eclipse.org/jdtls/snapshots/jdt-language-server-0.32.0-201901171733.tar.gz"
  sha256 "62214f67aa16ca3e4c0c14ecb1a0584cab9045f77c1494ce4985f8008c22d5f2"
  version "0.32.0-201901171733"

  bottle :unneeded

  depends_on :java => "1.8+"

  def install
    rm_rf "config_linux"
    rm_rf "config_win"
    libexec.install ["config_mac", "features", "plugins"]

    (bin/"jdt-ls").write <<~EOS
      #!/bin/bash
      JDT_LS_HOME="#{libexec}"
      JDT_LS_LAUNCHER=$(find $JDT_LS_HOME -name "org.eclipse.equinox.launcher_*.jar")
      JDT_LS_HEAP_SIZE=${JDT_LS_HEAP_SIZE:=-Xmx1G}
      java \
        -Declipse.application=org.eclipse.jdt.ls.core.id1 \
        -Dosgi.bundles.defaultStartLevel=4 \
        -Declipse.product=org.eclipse.jdt.ls.core.product \
        -Dlog.protocol=true \
        -Dlog.level=ALL \
        -noverify \
        $JDT_LS_HEAP_SIZE \
        -jar "$JDT_LS_LAUNCHER" \
        -configuration "$JDT_LS_HOME/config_mac" \
        --add-modules=ALL-SYSTEM \
        --add-opens java.base/java.util=ALL-UNNAMED \
        --add-opens java.base/java.lang=ALL-UNNAMED \
        "$@"
    EOS
  end
end
