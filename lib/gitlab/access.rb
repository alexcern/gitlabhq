# Gitlab::Access module
#
# Define allowed roles that can be used
# in GitLab code to determine authorization level
#
module Gitlab
  module Access
    GUEST     = 10
    REPORTER  = 20
    DEVELOPER = 30
    MASTER    = 40
    OWNER     = 50

    # Branch protection settings
    PROTECTION_NONE         = 0
    PROTECTION_DEV_CAN_PUSH = 1
    PROTECTION_FULL         = 2

    class << self
      def values
        options.values
      end

      def all_values
        options_with_owner.values
      end

      def options
        {
          "Guest"     => GUEST,
          "Reporter"  => REPORTER,
          "Developer" => DEVELOPER,
          "Master"    => MASTER,
        }
      end

      def options_with_owner
        options.merge(
          "Owner" => OWNER
        )
      end

      def sym_options
        {
          guest:     GUEST,
          reporter:  REPORTER,
          developer: DEVELOPER,
          master:    MASTER,
        }
      end

      def protection_options
        {
          "Not protected, developers and masters can (force) push and delete the branch" => PROTECTION_NONE,
          "Partially protected, developers can also push but prevent all force pushes and deletion" => PROTECTION_DEV_CAN_PUSH,
          "Fully protected, only masters can push and prevent all force pushes and deletion" => PROTECTION_FULL,
        }
      end

      def protection_values
        protection_options.values
      end
    end

    def human_access
      Gitlab::Access.options_with_owner.key(access_field)
    end

    def owner?
      access_field == OWNER
    end
  end
end
