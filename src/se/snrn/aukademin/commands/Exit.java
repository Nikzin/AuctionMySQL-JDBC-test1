package se.snrn.aukademin.commands;


public class Exit implements CommandState {

    private Boolean ifLoginMenu = false;

    public Exit(Boolean ifLoginMenu) {
        this.ifLoginMenu = ifLoginMenu;
    }

    @Override
    public void enter() {
        System.out.println("What do you want to do?");
        System.out.println("1. exit program");
        System.out.println("2. go to the main menu");


    }

    @Override
    public CommandState handleInput2(String input) {
        try {
            Integer.parseInt(input);
        }
        catch (Exception e) {
            System.out.println("your input is not in the choice list, please try again:");
            return new Exit(ifLoginMenu);}

            switch (Integer.parseInt(input)) {
                case 1: {
                    System.exit(0);
                }
                case 2: {
                    if (!ifLoginMenu) {
                        return new MainMenu();
                    }
                    System.out.println("cannot go to main menu before you login: ");
                    return new LoginCommand();
                }
                default: {
                    System.out.println("your input is not in the choice list, please try again:");
                    return new Exit(ifLoginMenu);
                }

            }

        }

}



