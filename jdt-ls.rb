class JdtLs < Formula
  desc "A Java language specific implementation of the Language Server Protocol"
  homepage "https://github.com/eclipse/eclipse.jdt.ls"

  url "http://download.eclipse.org/jdtls/milestones/0.38.0/jdt-language-server-0.38.0-201905021936.tar.gz"
  sha256 "83f1fe763992b35f54974159d70f5849d5947d123e821d71c52c2c9baee28f61"
  version "0.38.0-201905021936"

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
        -Dfile.encoding=utf8 \
        -Dlog.protocol=true \
        -Dlog.level=ALL \
        -noverify \
        $JDT_LS_HEAP_SIZE \
        -jar "$JDT_LS_LAUNCHER" \
        --add-modules=ALL-SYSTEM \
        --add-opens java.base/java.util=ALL-UNNAMED \
        --add-opens java.base/java.lang=ALL-UNNAMED \
        -configuration "$JDT_LS_HOME/config_mac" \
        "$@"
    EOS
  end
end
