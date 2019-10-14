defmodule Message do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          metadata: String.t(),
          dataset_id: String.t(),
          operational: Operational.t() | nil,
          payload: String.t(),
          version: String.t()
        }
  defstruct [:metadata, :dataset_id, :operational, :payload, :version]

  field(:metadata, 1, type: :string)
  field(:dataset_id, 2, type: :string)
  field(:operational, 3, type: Operational)
  field(:payload, 4, type: :string)
  field(:version, 5, type: :string)
end

defmodule Operational do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          timing: [Timing.t()]
        }
  defstruct [:timing]

  field(:timing, 1, repeated: true, type: Timing)
end

defmodule Timing do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          app: String.t(),
          end_time: String.t(),
          label: String.t(),
          start_time: String.t()
        }
  defstruct [:app, :end_time, :label, :start_time]

  field(:app, 1, type: :string)
  field(:end_time, 2, type: :string)
  field(:label, 3, type: :string)
  field(:start_time, 4, type: :string)
end
