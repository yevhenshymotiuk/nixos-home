{ pkgs ? import <nixpkgs> { }, rubyPackages ? pkgs.rubyPackages_2_6 }:

with pkgs;

mkShell {
  buildInputs = [ libmysqlclient libxml2 sqlite zlib ]
    ++ (with rubyPackages; [ rspec-core ]);
}
