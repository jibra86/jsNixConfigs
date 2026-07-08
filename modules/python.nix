{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (python3.withPackages (ps: with ps; [ 
      pip 
      tkinter 
      turtle
      ipython
    ]))
  ];
}
