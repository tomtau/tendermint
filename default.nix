with import <nixpkgs>{};

buildGoPackage rec {
  name = "tendermint";

  goPackagePath = "github.com/tendermint/tendermint";

  src = ./.;
  
  buildInputs = [ makeWrapper ];
  binPath = lib.makeBinPath [ git nix-prefetch-git mercurial nix-prefetch-hg ];

  goDeps = ./deps.nix;

  postInstall = ''
    wrapProgram $bin/bin/tendermint --prefix PATH ':' ${binPath}
  '';
  
  meta = with stdenv.lib; {
    description = "Tendermint Core (BFT Consensus) in Go";
    license = licenses.asl20;
    homepage = https://github.com/tendermint/tendermint;
  };
}
