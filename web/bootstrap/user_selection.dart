abstract class UserSelection<T> {
  const UserSelection._();

  const factory UserSelection.single(
    T selected,
    void Function(T) onChanged,
  ) = _UserSelectionSingle;
  const factory UserSelection.many(
    Set<T> selected,
    void Function(Set<T>) onChanged,
  ) = _UserSelectionMany;
  const factory UserSelection.indeterminate(
    T? selected,
    void Function(T?) onChanged,
  ) = _UserSelectionIndeterminate;

  Set<T> selectedSet() {
    return when(
      single: (v) => {v.selected},
      many: (v) => v.selected,
      indeterminate: (v) => {if (v.selected != null) v.selected!},
    );
  }

  void onSelect(T value) {
    when(
      single: (v) => v.onChanged(value),
      many: (v) {
        final _selected = {...v.selected};
        if (!_selected.remove(value)) {
          _selected.add(value);
        }
        v.onChanged(_selected);
      },
      indeterminate: (v) => v.onChanged(
        value == v.selected ? null : value,
      ),
    );
  }

  O when<O>({
    required O Function(_UserSelectionSingle<T>) single,
    required O Function(_UserSelectionMany<T>) many,
    required O Function(_UserSelectionIndeterminate<T>) indeterminate,
  }) {
    final v = this;
    if (v is _UserSelectionSingle<T>) return single(v);
    if (v is _UserSelectionMany<T>) return many(v);
    if (v is _UserSelectionIndeterminate<T>) return indeterminate(v);
    throw Error();
  }
}

class _UserSelectionSingle<T> extends UserSelection<T> {
  final T selected;
  final void Function(T) onChanged;

  const _UserSelectionSingle(this.selected, this.onChanged) : super._();
}

class _UserSelectionMany<T> extends UserSelection<T> {
  final Set<T> selected;
  final void Function(Set<T>) onChanged;

  const _UserSelectionMany(this.selected, this.onChanged) : super._();
}

class _UserSelectionIndeterminate<T> extends UserSelection<T> {
  final T? selected;
  final void Function(T?) onChanged;

  const _UserSelectionIndeterminate(this.selected, this.onChanged) : super._();
}
